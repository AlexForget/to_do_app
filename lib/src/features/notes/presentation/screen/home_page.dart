import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/src/features/notes/bloc/note_bloc.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/features/notes/models/note_model_box.dart';
import 'package:to_do_app/src/features/notes/presentation/widget/note_dialogbox.dart';
import 'package:to_do_app/src/helpers/app_sizes.dart';
import 'package:to_do_app/src/features/notes/presentation/widget/custom_dialog_box.dart';
import 'package:to_do_app/src/features/notes/presentation/widget/to_do_note.dart';

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

  TextEditingController _controller = TextEditingController();

  void checkBoxChanged(bool value, int index) {
    setState(() {
      NoteModel note = boxNotes.getAt(index);
      note.completed = value;
      boxNotes.putAt(index, note);
    });
  }

  void editTask(int index) {
    _controller = getTaskText(index);
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          controller: _controller,
          onSave: () => {
            updateEditTask(index),
            Navigator.pop(context),
          },
          onCancel: () => {
            _controller.text = "",
            Navigator.pop(context),
          },
          title: AppLocalizations.of(context)!.modifyNote,
        );
      },
    );
  }

  void updateEditTask(int index) {
    setState(() {
      NoteModel note = boxNotes.getAt(index);
      note.description = _controller.text;
      boxNotes.putAt(index, note);
      _controller.text = "";
    });
  }

  void confirmDeleteTask(index) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          onSave: () => {
            deleteTask(index),
            Navigator.pop(context),
          },
          onCancel: () => Navigator.pop(context),
          title: AppLocalizations.of(context)!.deleteNote,
          message: AppLocalizations.of(context)!.confirmDeleteNote,
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      boxNotes.deleteAt(index);
    });
  }

  TextEditingController getTaskText(int index) {
    TextEditingController temp = TextEditingController();
    NoteModel note = boxNotes.getAt(index);
    temp.text = note.description;
    return temp;
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
        onPressed: () => {
          showDialog(
            context: context,
            builder: (context) {
              return NoteDialogBox(
                title: AppLocalizations.of(context)!.newNote,
                hint: AppLocalizations.of(context)!.addNewNote,
              );
            },
          )
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
      body: Padding(
        padding: const EdgeInsets.only(top: Sizes.p12),
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: Sizes.p64),
              itemCount: boxNotes.length,
              itemBuilder: (context, index) {
                NoteModel noteModel = boxNotes.getAt(index);
                return BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    return ToDoNote(
                      taskName: noteModel.description,
                      taskCompleted: noteModel.completed,
                      onChanged: (value) => checkBoxChanged(value!, index),
                      deleteNote: () => confirmDeleteTask(index),
                      editNote: () => editTask(index),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
