import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_notes_app/app/models/note.dart';
import 'package:minimal_notes_app/app/models/note_repository.dart';
import 'package:minimal_notes_app/app/shared/components/custom_alert_dialog.dart';
import 'package:minimal_notes_app/app/shared/components/custom_drawer.dart';
import 'package:minimal_notes_app/app/shared/components/note_tile.dart';
import 'package:minimal_notes_app/app/shared/theme/app_colors.dart';
import 'package:minimal_notes_app/app/shared/util/validator.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _newNoteController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _readNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NotesRepository notesRepository = context.watch<NotesRepository>();
    List<Note> notesList = notesRepository.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                final note = notesList[index];
                return NoteTile(
                  text: note.text,
                  onEditPressed: () => _updateNote(note),
                  onDeletePressed: () => _deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: _createNote,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }

  void _createNote() {
    showDialog(
        context: context,
        builder: (context) {

          return CustomAlertDialog(
            title: 'New Note',
            content: Form(
              key: _formKey,
              child: TextFormField(
                validator: Validator.isRequired,
                controller: _newNoteController,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Write your note here...'),
                cursorColor: colorInversePrimaryDark,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
              ),
            ),
            confirmationTitle: 'Create',
            onConfirmationPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<NotesRepository>().addNote(_newNoteController.text);
                _newNoteController.clear();
                Navigator.pop(context);
              }
            },
          );
        });
  }

  void _readNotes() {
    context.read<NotesRepository>().fetchNotes();
  }

  void _updateNote(Note note) {
    _newNoteController.text = note.text;

    showDialog(
      context: context,
      builder: (context) {

        return CustomAlertDialog(
          content: Form(
            key: _formKey,
            child: TextFormField(
              validator: Validator.isRequired,
              controller: _newNoteController,
              autofocus: true,
            ),
          ),
          confirmationTitle: 'Update',
          onConfirmationPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              context.read<NotesRepository>().updateNote(id: note.id, edittedText: _newNoteController.text);
              _newNoteController.clear();
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  void _deleteNote(int id) {
    context.read<NotesRepository>().deleteNote(id);
  }
}
