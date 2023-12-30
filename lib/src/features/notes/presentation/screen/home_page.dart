import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/src/features/notes/bloc/note_list_bloc.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/helpers/app_sizes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildNoteTile(BuildContext context, NoteModel note) {
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
                                note.description =
                                    descriptionController.text.trim();
                                context
                                    .read<NoteListBloc>()
                                    .add(UpdateNote(note: note));
                                Navigator.pop(context);
                                descriptionController.text = '';
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
                    context.read<NoteListBloc>().add(
                          DeleteNote(note: note),
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

  void showAddNoteCustomDialog({
    required BuildContext context,
    bool isEdit = false,
  }) =>
      showDialog(
        context: context,
        builder: (context) {
          TextEditingController descriptionController = TextEditingController();
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.record),
            content: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.addNewNote),
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
                  final note = NoteModel(
                    description: descriptionController.text.trim(),
                    completed: false,
                  );
                  if (isEdit) {
                    context.read<NoteListBloc>().add(UpdateNote(note: note));
                  } else {
                    context.read<NoteListBloc>().add(AddNote(note: note));
                  }
                  Navigator.pop(context);
                  descriptionController.text = '';
                },
                child: Text(
                  AppLocalizations.of(context)!.record,
                ),
              ),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        label: Text(AppLocalizations.of(context)!.add),
        icon: const Icon(Icons.add),
        onPressed: () {
          showAddNoteCustomDialog(context: context);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.title,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4.0,
        shadowColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: BlocBuilder<NoteListBloc, NoteListState>(
        builder: (context, state) {
          if ((state is NoteListUpdated || state is NoteListInitial) &&
              state.notes.isNotEmpty) {
            final notes = state.notes;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return buildNoteTile(context, note);
              },
            );
          } else {
            return SizedBox(
              width: double.infinity,
              child: Center(
                  child: Text(AppLocalizations.of(context)!.noNoteRegister)),
            );
          }
        },
      ),
    );
  }
}
