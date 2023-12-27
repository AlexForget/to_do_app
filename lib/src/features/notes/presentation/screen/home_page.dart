import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/src/features/notes/bloc/note_list_bloc.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/helpers/app_sizes.dart';
import 'package:to_do_app/src/localisation/string_hardcoded.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

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
              onChanged: (value) => value = false, // TODO : UPDATE
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
                  onPressed: () {}, // TODO : UPDATE
                  color: Theme.of(context).colorScheme.primary,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    context.read<NoteListBloc>().add(
                          DeleteNote(note: note),
                        );
                  }, // TODO : UPDATE
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showCustomDialog({
    required BuildContext context,
    bool isEdit = false,
    required int id,
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
                  context.read<NoteListBloc>().add(
                        AddNote(
                          note: NoteModel(
                              description: descriptionController.text.trim(),
                              completed: false,
                              id: id),
                        ),
                      );
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
          final state = context.read<NoteListBloc>().state;
          final id = state.notes.length;
          showCustomDialog(context: context, id: id);
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
          if (state is NoteListUpdated && state.notes.isNotEmpty) {
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
              child: Center(child: Text('No note register'.hardcoded)),
            );
          }
        },
      ),
    );
  }
}
