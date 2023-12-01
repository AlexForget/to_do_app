import 'package:flutter/material.dart';
import 'package:to_do_app/src/localisation/string_hardcoded.dart';
import 'package:to_do_app/src/widgets/my_button.dart';

class DialogBoxWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBoxWidget({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Nouvelle note".hardcoded),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: "Add a new task".hardcoded),
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
