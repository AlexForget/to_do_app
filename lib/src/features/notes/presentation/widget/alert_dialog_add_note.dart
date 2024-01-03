import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/src/features/notes/bloc/note_list_bloc.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';

class AlertDialogAddNote extends StatelessWidget {
  const AlertDialogAddNote({
    super.key,
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.record),
      content: TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: descriptionController,
        decoration:
            InputDecoration(hintText: AppLocalizations.of(context)!.addNewNote),
        minLines: 1,
        maxLines: 5,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(context)!.cancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          onPressed: () {
            if (descriptionController.text.isNotEmpty) {
              final note = NoteModel(
                description: descriptionController.text.trim(),
                completed: false,
              );
              context.read<NoteListBloc>().add(AddNote(note: note));
              Navigator.pop(context);
              descriptionController.text = '';
            }
          },
          child: Text(
            AppLocalizations.of(context)!.record,
          ),
        ),
      ],
    );
  }
}
