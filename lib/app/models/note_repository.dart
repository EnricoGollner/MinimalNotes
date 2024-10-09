import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:minimal_notes_app/app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NotesRepository extends ChangeNotifier {
  static late Isar isar;

  // Initializing Database()
  static Future<void> initialize() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // List of notes
  final List<Note> currentNotes = [];

  // Create
  Future<void> addNote(String typedText) async {
    final Note newNote = Note()..text = typedText;
    await isar.writeTxn(() => isar.notes.put(newNote));
    await getNotes();
  }

  // Read
  Future<void> getNotes() async {
    List<Note> getNotes = await isar.notes.where().findAll();

    currentNotes.clear();
    currentNotes.addAll(getNotes);
    notifyListeners();
  }

  // Update
  Future<void> updateNote({required int id, required String edittedText}) async {
    final Note? existingNote = await isar.notes.get(id);

    if (existingNote != null) {
      existingNote.text = edittedText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await getNotes();
    }
  }

  // Delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await getNotes();
  }
}