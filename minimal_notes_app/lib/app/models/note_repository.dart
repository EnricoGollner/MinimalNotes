import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:minimal_notes_app/app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NotesRepository extends ChangeNotifier {
  static late Isar isar;

  // Initializing Database()
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // List of notes
  final List<Note> currentNotes = [];

  // Create
  Future<void> addNote(String typedText) async {
    final newNote = Note()..text = typedText;

    await isar.writeTxn(() => isar.notes.put(newNote));
    await fetchNotes();
  }

  // Read
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();

    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    
    notifyListeners();
  }

  // Update
  Future<void> updateNote({required int id, required String edittedText}) async {
    final Note? existingNote = await isar.notes.get(id);

    if (existingNote != null) {
      existingNote.text = edittedText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // Delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}