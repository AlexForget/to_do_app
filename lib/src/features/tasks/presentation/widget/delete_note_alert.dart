import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/src/features/tasks/bloc/task_list_bloc.dart';
import 'package:to_do_app/src/features/tasks/models/task_model.dart';

class DeleteNoteAlertDialog extends StatelessWidget {
  const DeleteNoteAlertDialog({
    super.key,
    required this.note,
  });

  final TaskModel note;

  @override
  Widget build(BuildContext context) {
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
            context.read<TaskListBloc>().add(
                  DeleteTask(task: note),
                );
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context)!.deleteNote,
          ),
        ),
      ],
    );
  }
}
