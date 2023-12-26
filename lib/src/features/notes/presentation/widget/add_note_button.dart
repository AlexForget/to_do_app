import 'package:flutter/material.dart';

class AddNoteButton extends StatelessWidget {
  const AddNoteButton(
      {super.key, required this.buttonLabel, required this.onPressed});

  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(buttonLabel),
    );
  }
}
