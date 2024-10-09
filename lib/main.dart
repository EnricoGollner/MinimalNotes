import 'package:flutter/material.dart';
import 'package:minimal_notes_app/app/models/note_repository.dart';
import 'package:minimal_notes_app/app/shared/theme/theme_provider.dart';
import 'package:minimal_notes_app/main_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Initializing note Isar Database
  WidgetsFlutterBinding.ensureInitialized();
  await NotesRepository.initialize();

  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NotesRepository()),
      ChangeNotifierProvider(create: (_) => ThemeProvider())
    ],
    child: const MainApp(),
  )
  );
}
