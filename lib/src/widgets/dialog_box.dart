import 'package:flutter/material.dart';
import 'package:to_do_app/src/localisation/string_hardcoded.dart';
import 'package:to_do_app/src/widgets/my_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogBoxWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? message;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String title;
  final String? hint;

  const DialogBoxWidget({
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
        MyButtonWidget(
          buttonLabel: AppLocalizations.of(context)!.cancel,
          onPressed: onCancel,
        ),
        MyButtonWidget(
          buttonLabel: message == null
              ? AppLocalizations.of(context)!.record
              : AppLocalizations.of(context)!.delete,
          onPressed: onSave,
        ),
      ],
    );
  }
}
