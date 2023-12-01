import 'package:flutter/material.dart';
import 'package:to_do_app/src/localisation/string_hardcoded.dart';
import 'package:to_do_app/src/widgets/my_button.dart';

class DialogBoxWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String title;
  final String hint;

  const DialogBoxWidget({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.title,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hint),
        minLines: 1,
        maxLines: 5,
      ),
      actions: <Widget>[
        MyButtonWidget(
          buttonLabel: "Annuler".hardcoded,
          onPressed: onCancel,
        ),
        MyButtonWidget(
          buttonLabel: "Enregistrer".hardcoded,
          onPressed: onSave,
        ),
      ],
    );
  }
}
