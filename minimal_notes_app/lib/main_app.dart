import 'package:flutter/material.dart';
import 'package:minimal_notes_app/app/pages/notes_page.dart';
import 'package:minimal_notes_app/app/shared/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const NotesPage(),
    );
  }
}