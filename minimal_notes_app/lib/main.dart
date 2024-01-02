import 'package:flutter/material.dart';
import 'package:minimal_notes_app/app/models/note_repository.dart';
import 'package:minimal_notes_app/main_app.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initializing note Isar Database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteRepository.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteRepository(),
      builder: (context, child) => const MainApp(),
    ),
  );
}
