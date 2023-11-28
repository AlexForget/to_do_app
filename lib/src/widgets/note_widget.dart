import 'package:flutter/material.dart';
import 'package:to_do_app/src/constants/app_sizes.dart';
import 'package:to_do_app/src/localisation/string_hardcoded.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({super.key});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(Sizes.p24, Sizes.p12, Sizes.p24, Sizes.p12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.all(
            radius12,
          ),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Text("some todo task".hardcoded),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: Sizes.p12),
              child: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
