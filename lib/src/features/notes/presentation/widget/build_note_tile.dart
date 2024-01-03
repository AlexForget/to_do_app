import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/src/features/notes/bloc/note_list_bloc.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/helpers/app_sizes.dart';

class BuildNoteTile extends StatelessWidget {
  const BuildNoteTile({
    super.key,
    required this.context,
    required this.note,
  });

  final BuildContext context;
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Sizes.p24, right: Sizes.p24, top: Sizes.p12, bottom: Sizes.p12),
      child: Container(
        padding: const EdgeInsets.all(Sizes.p8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(radius12),
            color: Theme.of(context).colorScheme.primaryContainer),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                                  note.description =
                                      descriptionController.text.trim();
                                  context
                                      .read<NoteListBloc>()
                                      .add(UpdateNote(note: note));
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
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context)!.delete),
                          actions: <Widget>[
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.cancel),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<NoteListBloc>().add(
                                      DeleteNote(note: note),
                                    );
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.deleteNote,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
