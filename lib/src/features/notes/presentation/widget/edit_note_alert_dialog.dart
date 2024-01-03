import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/src/features/notes/bloc/note_list_bloc.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';

class EditNoteAlertDialog extends StatelessWidget {
  const EditNoteAlertDialog({
    super.key,
    required this.descriptionController,
    required this.note,
  });

  final TextEditingController descriptionController;
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.modifyNote),
      content: TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: descriptionController,
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
              note.description = descriptionController.text.trim();
              context.read<NoteListBloc>().add(UpdateNote(note: note));
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
