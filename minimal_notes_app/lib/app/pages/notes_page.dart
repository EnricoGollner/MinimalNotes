import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_notes_app/app/models/note.dart';
import 'package:minimal_notes_app/app/models/note_repository.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _newNoteController = TextEditingController();

  @override
  void initState() {
    readNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NotesRepository notesRepository = context.watch<NotesRepository>();
    List<Note> notesList = notesRepository.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary,),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
              final note = notesList[index];
            
                return ListTile(
                  title: Text(note.text),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => updateNote(note),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => deleteNote(note.id),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
            },),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
    );
  }

  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _newNoteController,
        ),
        actions: [
          MaterialButton(
            onPressed: (){
              context.read<NotesRepository>().addNote(_newNoteController.text);
              _newNoteController.clear();
              Navigator.pop(context);
            },
            child: const Text('Create'),
          )
        ],
      ),
    );
  }

  void readNotes() {
    context.read<NotesRepository>().fetchNotes();
  }

  void updateNote(Note note) {
    _newNoteController.text = note.text;

    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Update Note'),
        content: TextField(
          controller: _newNoteController,
        ),
        actions: [
          MaterialButton(
            onPressed: (){
              context.read<NotesRepository>().updateNote(id: note.id, edittedText: _newNoteController.text);
              _newNoteController.clear();
              Navigator.pop(context);
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }

  void deleteNote(int id) {
    context.read<NotesRepository>().deleteNote(id: id);
  }
}