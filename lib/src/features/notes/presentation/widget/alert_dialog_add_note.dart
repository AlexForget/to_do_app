import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:to_do_app/src/features/notes/bloc/note_list_bloc.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/helpers/app_sizes.dart';
import 'package:to_do_app/src/localisation/string_hardcoded.dart';

class AlertDialogAddNote extends StatefulWidget {
  AlertDialogAddNote({super.key});

  final TextEditingController descriptionController = TextEditingController();

  @override
  State<AlertDialogAddNote> createState() => _AlertDialogAddNoteState();
}

class _AlertDialogAddNoteState extends State<AlertDialogAddNote> {
  static const List<String> notificationType = <String>[
    'Unique',
    'Weekly',
    'Monthly',
    'Annualy'
  ];
  DateTime? notificationTime;
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
              child: notificationTime != null
                  ? Text(
                      textAlign: TextAlign.center,
                      '${AppLocalizations.of(context)!.notificationWillBeSent} $formattedDate')
                  : null,
            ),
            DropdownMenu<String>(
              label: Text('Frequency'.hardcoded),
              initialSelection: notificationType.first,
              dropdownMenuEntries: notificationType
                  .map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry(value: value, label: value);
              }).toList(),
            )
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
              final note = NoteModel(
                description: widget.descriptionController.text.trim(),
                completed: false,
                notification: notificationTime,
              );
              context.read<NoteListBloc>().add(AddNote(note: note));
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
    notificationTime = await showOmniDateTimePicker(
      context: context,
      firstDate: DateTime.now(),
      is24HourMode: true,
    );
    if (notificationTime != null) {
      setState(() {
        formattedDate =
            DateFormat.MMMd(deviceLocal).add_Hm().format(notificationTime!);
      });
    }
  }
}
