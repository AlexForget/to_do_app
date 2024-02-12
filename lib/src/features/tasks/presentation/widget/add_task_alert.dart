import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:to_do_app/src/features/tasks/bloc/task_list_bloc.dart';
import 'package:to_do_app/src/features/tasks/models/task_model.dart';
import 'package:to_do_app/src/helpers/app_sizes.dart';

class AlertDialogAddTask extends StatefulWidget {
  AlertDialogAddTask({super.key});

  final TextEditingController descriptionController = TextEditingController();

  @override
  State<AlertDialogAddTask> createState() => _AlertDialogAddTaskState();
}

class _AlertDialogAddTaskState extends State<AlertDialogAddTask> {
  DateTime? notificationDateTime;
  String formattedDate = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.record),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: widget.descriptionController,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.addNewNote),
              minLines: 1,
              maxLines: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: Sizes.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
                    ),
                    onPressed: () async {
                      setNotification();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: Sizes.p12),
                          child: Text(
                            AppLocalizations.of(context)!.addReminder,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Sizes.p16, bottom: Sizes.p16),
              child: notificationDateTime != null
                  ? Text(
                      textAlign: TextAlign.center,
                      '${AppLocalizations.of(context)!.notificationWillBeSent} $formattedDate')
                  : null,
            ),
          ],
        ),
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
            if (widget.descriptionController.text.isNotEmpty) {
              final task = TaskModel(
                description: widget.descriptionController.text.trim(),
                completed: false,
                notification: notificationDateTime,
              );
              context.read<TaskListBloc>().add(AddTask(task: task));
              Navigator.pop(context);
              widget.descriptionController.text = '';
            }
          },
          child: Text(
            AppLocalizations.of(context)!.record,
          ),
        ),
      ],
    );
  }

  void setNotification() async {
    final String deviceLocal = Platform.localeName;
    notificationDateTime = await showOmniDateTimePicker(
      context: context,
      firstDate: DateTime.now(),
      is24HourMode: true,
    );
    if (notificationDateTime != null) {
      setState(() {
        formattedDate =
            DateFormat.MMMd(deviceLocal).add_Hm().format(notificationDateTime!);
      });
    }
  }
}
