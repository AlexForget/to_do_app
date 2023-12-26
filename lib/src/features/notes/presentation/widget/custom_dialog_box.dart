import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/src/features/notes/presentation/widget/add_note_button.dart';

class CustomDialogBox extends StatelessWidget {
  final TextEditingController? controller;
  final String? message;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String title;
  final String? hint;

  const CustomDialogBox({
    super.key,
    this.controller,
    this.message,
    required this.onSave,
    required this.onCancel,
    required this.title,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: message == null
          ? TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              decoration: InputDecoration(hintText: hint),
              minLines: 1,
              maxLines: 5,
            )
          : Text(message!),
      actions: <Widget>[
        AddNoteButton(
          buttonLabel: AppLocalizations.of(context)!.cancel,
          onPressed: onCancel,
        ),
        AddNoteButton(
          buttonLabel: message == null
              ? AppLocalizations.of(context)!.record
              : AppLocalizations.of(context)!.delete,
          onPressed: onSave,
        ),
      ],
    );
  }
}
