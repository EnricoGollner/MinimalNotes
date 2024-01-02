import 'package:flutter/material.dart';
import 'package:minimal_notes_app/app/pages/notes_page.dart';
import 'package:minimal_notes_app/app/pages/settings_page.dart';
import 'package:minimal_notes_app/app/shared/components/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(Icons.edit),
          ),
          const SizedBox(height: 25),
          DrawerTile(
            title: 'Notes',
            leading: const Icon(Icons.home),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NotesPage(),)),
          ),
          DrawerTile(
            title: 'Settings',
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
