import 'dart:developer' as dev show log;
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:gamers_notes/data/state.dart';
import 'package:gamers_notes/pages/note/image.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as image;

import '../data/notes.dart';

const minX = 8;
const minY = 8;
const minYForEditing = 35;

class NoteScreen extends StatefulWidget {
  final String noteID;

  const NoteScreen({super.key, required this.noteID});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late Note _note;
  bool _editing = false;
  final QuillController _editorController = QuillController.basic();
  String? _selectedImg;

  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        return WillPopScope(
          onWillPop: () async {
            await _closeAndSave();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "${_note.name} "),
                    TextSpan(text: "(${_note.id})", style: const TextStyle(fontSize: 13))
                  ]
                )
              ),
              leading: IconButton(onPressed: () {
                _closeAndSave().then((_) => context.pop());
              }, icon: const Tooltip(message: "Back", child: Icon(Icons.arrow_back))),
              actions: [
                IconButton(
                  icon: Icon((_editing) ? Icons.edit_off_sharp : Icons.edit),
                  onPressed: () => setState(() {
                    _editing = !_editing;
                  }),
                )
              ],
            ),
            body: Center(
              child: Stack(
                children: () {
                  final list = <Widget>[
                    GestureDetector(
                      onTap: () => setState(() {
                        _selectedImg = null;
                      }),
                      child: Column(
                        children: [
                          if (_editing) QuillToolbar.basic(
                            controller: _editorController,
                            customButtons: [
                              QuillCustomButton(
                                icon: Icons.image,
                                onTap: () async {
                                  final res = await FilePicker.platform.pickFiles(
                                    withData: true,
                                    lockParentWindow: true,
                                    type: FileType.image
                                  );
                                  if (res == null) return;
                                  final data = res.files.first.bytes!;
                                  final img = image.decodeImage(data)!;
                                  final name = res.names[0]!;
                                  final newNote = _note.addImage(
                                    ImageElement(
                                      id: generateID(name),
                                      imageData: data,
                                      relX: 0,
                                      relY: 0,
                                      pageNum: 0,
                                      width: img.width,
                                      height: img.height
                                    )
                                  );
                                  setState(() {
                                    _note = newNote;
                                  });
                                },
                              )
                            ],
                          ),
                          Expanded(
                            child: QuillEditor(
                              controller: _editorController,
                              readOnly: !_editing,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              autoFocus: false,
                              scrollable: true,
                              expands: true,
                              focusNode: _focusNode,
                              scrollController: _scrollController,
                              onTapDown: (details, p1) {
                                setState(() {
                                  _selectedImg = null;
                                });
                                return false;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                  list.addAll(_note.imageElements.map((id, img) {
                    final res = Positioned(
                      left: max(img.relX.toDouble(), minX.toDouble()),
                      top: max(img.relY.toDouble() + ((_editing) ? minYForEditing : 0), ((_editing) ? minYForEditing : minY).toDouble()),
                      child: GestureDetector(
                        onLongPressEnd: (details) => _showEditDialog(id, details.globalPosition),
                        onSecondaryTapUp: (details) => _showEditDialog(id, details.globalPosition),
                        child: NoteImage(
                          key: ValueKey(img.id),
                          imageData: img.imageData,
                          onLocationChanged: (offset) {
                            final size = MediaQuery.of(context).size;
                            setState(() {
                              _note = _note.moveImage(id,
                                  min(max(img.relX + offset.dx, minX), size.width - minX),
                                  min(max(img.relY + offset.dy, minYForEditing),
                                      size.height - minYForEditing));
                            });
                          },
                          onSizeUpdate: (offset, from) {
                            // dev.log(offset.toString());
                            setState(() {
                              _note = _note.replaceImage(id, img.copy(
                                width: img.width + offset.dx,
                                height: img.height + offset.dy
                              ));
                            });
                          },
                          width: img.width,
                          height: img.height,
                          selected: _selectedImg == id,
                          onSelection: () => setState(() {
                            _selectedImg = id;
                          }),
                          editable: _editing,
                        )
                      ),
                    );
                    return MapEntry(id, res);
                  }).values.toList());
                  return list;
                }(),
              )
            )
          ),
        );
      }
    );
  }

  @override
  void initState() {
    _note = Provider.of<AppState>(context, listen: false).notes[widget.noteID]!;
    super.initState();
  }

  void _showEditDialog(String id, Offset pos) async {
    showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(pos.dx, pos.dy, pos.dx, pos.dy),
      items: <PopupMenuEntry<int>>[
        PopupMenuItem(
          onTap: () {
            final backUpNote = _note.copy();
            setState(() {
              _note = _note.removeImage(id);
            });
            final msgr = ScaffoldMessenger.of(context);
            msgr.clearSnackBars();
            msgr.showSnackBar(
              SnackBar(
                content: const Text("Image deleted."),
                action: SnackBarAction(label: "Undo!", onPressed: () => setState(() {
                  _note = backUpNote;
                })),
              )
            );
          },
          height: 30,
          child: const Text("Delete"),
        )
      ],
    );
  }

  Future<void> _closeAndSave() async {
    dev.log("saved note ${widget.noteID}");
  }
}