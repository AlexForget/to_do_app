// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:to_do_app/src/features/tasks/bloc/task_list_bloc.dart';
import 'package:to_do_app/src/features/tasks/presentation/widget/build_note_tile.dart';
import 'package:to_do_app/src/features/tasks/presentation/widget/add_task_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFabVisible = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        foregroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialogAddTask();
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        height: 35,
        shape: const CircularNotchedRectangle(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4.0,
        shadowColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: BlocBuilder<TaskListBloc, TaskListState>(
        builder: (context, state) {
          if ((state is TaskListUpdated || state is TaskListInitial) &&
              state.tasks.isNotEmpty) {
            final notes = state.tasks;
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.forward) {
                  if (!isFabVisible) setState(() => isFabVisible = true);
                } else if (notification.direction == ScrollDirection.reverse) {
                  if (isFabVisible) setState(() => isFabVisible = false);
                }
                return true;
              },
              child: ReorderableListView.builder(
                onReorder: (oldIndex, newIndex) {
                  context.read<TaskListBloc>().add(
                      ReorderedList(oldIndex: oldIndex, newIndex: newIndex));
                },
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return BuildNoteTile(
                    context: context,
                    note: note,
                    key: ObjectKey(note), //Key(notes[index].id.toString()),
                  );
                },
              ),
            );
          } else {
            return SizedBox(
              width: double.infinity,
              child: Center(
                  child: Text(AppLocalizations.of(context)!.noteNoteRegister)),
            );
          }
        },
      ),
    );
  }
}
