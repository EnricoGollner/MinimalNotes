import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String confirmationTitle;
  final Widget content;
  final void Function()? onConfirmationPressed;

  const CustomAlertDialog({
    super.key,
    this.title,
    this.onConfirmationPressed,
    required this.confirmationTitle,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: title != null
          ? Text(title!, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary))
          : null,
      content: content,
      actions: [
        MaterialButton(
          onPressed: onConfirmationPressed,
          child: Text(confirmationTitle),
        )
      ],
    );
  }
}
