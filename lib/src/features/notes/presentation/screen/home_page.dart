import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/src/features/notes/bloc/note_list_bloc.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/features/notes/presentation/screen/build_note_tile.dart';
import 'package:to_do_app/src/features/notes/presentation/widget/alert_dialog_add_note.dart';
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
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController descriptionController =
                  TextEditingController();
              return AlertDialogAddNote(
                  descriptionController: descriptionController);
            },
          );
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
                return BuildNoteTile(context: context, note: note);
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
