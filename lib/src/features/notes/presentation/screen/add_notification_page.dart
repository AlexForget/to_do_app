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

class AddNotification extends StatefulWidget {
  const AddNotification({
    super.key,
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  static const List<String> notificationType = <String>[
    'Unique',
    'Weekly',
    'Monthly',
    'Annualy'
  ];
  DateTime? notificationTime;
  String formattedDate = '';
  bool notificationIsSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.record,
                  style: TextStyle(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                ),
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
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
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
                  padding:
                      const EdgeInsets.only(top: Sizes.p16, bottom: Sizes.p16),
                  child: notificationIsSelected
                      ? Text(
                          textAlign: TextAlign.center,
                          '${AppLocalizations.of(context)!.notificationWillBeSent} $formattedDate')
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Sizes.p16),
                  child: DropdownMenu<String>(
                    label: Text('Kind of notification'.hardcoded),
                    menuHeight: 200,
                    enabled: notificationIsSelected,
                    onSelected: (notificationType) {
                      print(notificationType);
                    },
                    initialSelection: notificationType.first,
                    dropdownMenuEntries: notificationType
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry(value: value, label: value);
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (widget.descriptionController.text.isNotEmpty) {
                              final note = NoteModel(
                                description:
                                    widget.descriptionController.text.trim(),
                                completed: false,
                                notification: notificationTime,
                              );
                              context
                                  .read<NoteListBloc>()
                                  .add(AddNote(note: note));
                              Navigator.pop(context);
                              widget.descriptionController.text = '';
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.record),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
      notificationIsSelected = true;
      setState(() {
        formattedDate =
            DateFormat.MMMd(deviceLocal).add_Hm().format(notificationTime!);
      });
    }
  }
}
