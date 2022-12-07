import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'notes.dart';

String generateID(String name) => "${name.replaceAll(RegExp(r"[^a-zA-Z]"), "")}_${DateTime.now().millisecondsSinceEpoch}";

class AppState extends ChangeNotifier {
  AppState() {
    getApplicationDocumentsDirectory().then((dir) {
      _notesDir = Directory("${dir.path}/notes");
      _notesDir.create(recursive: true);
    });
  }

  bool loaded = false;
  final Map<String, Note> notes = {};

  final List<String> _changed = [];
  final List<String> _toDelete = [];
  late final Directory _notesDir;

  void load({bool notify = true}) {
    loaded = false;
    notes.clear();
    _changed.clear();
    _toDelete.clear();

    // TODO: Load notes (from disk? or shared prefs?)
    var id = generateID("Test-Note");
    notes[id] = Note(
      id: id,
      name: "Test-Note",
      paintElements: [],
      textElements: const [TextElement.fromText("Hallo.")],
      imageElements: {},
      creationTime: DateTime.fromMillisecondsSinceEpoch(102724),
      lastEditTime: DateTime.now()
    );
    id = generateID("Rekord gebrochen");
    notes[id] = Note(
      id: id,
      name: "Rekord gebrochen",
      paintElements: [],
      textElements: const [TextElement.fromText("Hallo.")],
      imageElements: {},
      creationTime: DateTime.fromMillisecondsSinceEpoch(102724),
      lastEditTime: DateTime.now()
    );
    _changed.add("wh");

    if (notify) notifyListeners();
    loaded = true;
  }

  void deleteNote(Note note, {bool thenSave = true}) {
    notes.remove(note.id);
    _toDelete.add(note.id);
    notifyListeners();
    if (thenSave) save();
  }

  Note createNote(String id, String name, String? parentId, {bool thenSave = true}) {
    final time = DateTime.now();
    final note = Note(
      id: id,
      name: name,
      parentId: parentId,
      creationTime: time,
      lastEditTime: time,
      imageElements: {},
      textElements: [],
      paintElements: []
    );
    notes[note.id] = note;
    notifyListeners();
    _changed.add(note.id);
    if (thenSave) save();
    return note;
  }

  bool saveNote(Note note) {
    if (!notes.containsKey(note.id)) return false;
    notes[note.id] = note;
    _changed.add(note.id);
    save();
    return true;
  }

  void save() async {
    final dir = _notesDir;
    for (var id in _changed) {
      if (!notes.containsKey(id)) continue;
      await File("${dir.path}/$id.gmrnote").writeAsString(jsonEncode(notes[id]));
    }
    for (var id in _toDelete) {
      await File("${dir.path}/$id.gmrnote").delete();
    }
    _toDelete.clear();
    _changed.clear();
  }
}
