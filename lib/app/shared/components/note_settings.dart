import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  const NoteSettings({super.key, this.onEditPressed, this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            onEditPressed!();
          },
          child: Ink(
            child: Container(
              height: 50,
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            onDeletePressed!();
          },
          child: Ink(
            child: Container(
              height: 50,
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
