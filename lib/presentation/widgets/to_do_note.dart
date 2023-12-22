import 'package:flutter/material.dart';
import 'package:to_do_app/helpers/app_sizes.dart';

class ToDoNote extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?) onChanged;
  final void Function() deleteNote;
  final void Function() editNote;

  const ToDoNote({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteNote,
    required this.editNote,
  });

  @override
  Widget build(BuildContext context) {
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
              value: taskCompleted,
              onChanged: onChanged,
            ),
            Expanded(
              child: Text(
                taskName,
                style: TextStyle(
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: editNote,
                  color: Theme.of(context).colorScheme.primary,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: deleteNote,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
