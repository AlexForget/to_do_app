// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/src/features/notes/bloc/note_list_bloc.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/features/notes/presentation/widget/delete_note_alert_dialog.dart';
import 'package:to_do_app/src/features/notes/presentation/widget/edit_note_alert_dialog.dart';
import 'package:to_do_app/src/helpers/app_sizes.dart';

class BuildNoteTile extends StatelessWidget {
  const BuildNoteTile({
    required Key key,
    required this.context,
    required this.note,
  }) : super(key: key);

  final BuildContext context;
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Sizes.p12, right: Sizes.p12, top: Sizes.p4, bottom: Sizes.p4),
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(radius8),
            color: Theme.of(context).colorScheme.primaryContainer),
        child: Padding(
          padding: const EdgeInsets.only(left: Sizes.p8, right: Sizes.p8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.drag_handle),
              Checkbox(
                value: note.completed,
                onChanged: (value) {
                  note.completed = value!;
                  context.read<NoteListBloc>().add(UpdateNote(note: note));
                },
              ),
              Expanded(
                child: Text(
                  note.description,
                  style: TextStyle(
                    decoration: note.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController descriptionController =
                              TextEditingController(text: note.description);
                          return EditNoteAlertDialog(
                            descriptionController: descriptionController,
                            note: note,
                          );
                        },
                      );
                    },
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteNoteAlertDialog(note: note);
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
