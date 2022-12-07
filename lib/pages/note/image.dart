import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class NoteImage extends StatefulWidget {
  final Uint8List imageData;
  final num width;
  final num height;
  final void Function(Offset offset) onLocationChanged;
  final void Function(Offset offset, Alignment from) onSizeUpdate;
  final bool selected;
  final void Function() onSelection;
  final bool editable;

  const NoteImage({
    super.key,
    required this.width,
    required this.height,
    required this.imageData,
    required this.onLocationChanged,
    required this.onSizeUpdate,
    required this.selected,
    required this.onSelection,
    required this.editable
  });

  @override
  State<NoteImage> createState() => _NoteImageState();
}

class _NoteImageState extends State<NoteImage> {
  Offset _moveOffset = const Offset(0, 0);
  Offset _dragStart = const Offset(0, 0);
  Offset _imageSize = const Offset(10, 10);
  bool _hideTheResizingDots = false;

  @override
  void initState() {
    _imageSize = Offset(widget.width.toDouble(), widget.height.toDouble());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rawImg = Image.memory(
      widget.imageData,
      width: _imageSize.dx,
      height: _imageSize.dy,
      fit: BoxFit.fill,
    );
    final imgDispl = (widget.selected) ? Container(
      decoration: BoxDecoration(
      border: Border.all(color: Colors.blue.shade700, width: 3)),
      child: rawImg
    ) : rawImg;
    return GestureDetector(
      onTap: widget.onSelection,
      child: Stack(
        children: [
          (widget.editable) ? Draggable(
            feedback: imgDispl,
            childWhenDragging: Container(),
            onDraggableCanceled: (velocity, offset) {
              widget.onLocationChanged(_moveOffset);
              setState(() {
                _moveOffset = const Offset(0, 0);
                _hideTheResizingDots = false;
              });
            },
            onDragUpdate: (details) {
              _moveOffset += details.delta;
            },
            onDragStarted: () {
              widget.onSelection();
              setState(() {
                _hideTheResizingDots = true;
              });
            },
            child: imgDispl
          ) : imgDispl,
          if (widget.selected && widget.editable && !_hideTheResizingDots) Align(
            alignment: Alignment.topLeft,
            child: Transform.translate(
              offset: const Offset(-3, -3),
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeUpLeft,
                child: GestureDetector(
                  onPanStart: (details) {
                    _dragStart = details.globalPosition;
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      _imageSize += _dragStart - details.globalPosition;
                    });
                    widget.onSizeUpdate(_dragStart - details.globalPosition, Alignment.topLeft);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade900
                    ),
                    width: 10,
                    height: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}