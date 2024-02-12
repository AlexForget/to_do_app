import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/src/features/tasks/models/task_model.dart';
import 'package:to_do_app/src/helpers/constants.dart';

late Box boxNotes;

class LocalDB {
  LocalDB();

  List<TaskModel> readTaskList() {
    final box = Hive.box<TaskModel>(noteHiveBox);
    return box.values.toList();
  }

  void createNewTask(TaskModel task) {
    boxNotes.add(task);
  }

  void deleteTask(TaskModel task) {
    int taskIndexToDelete = getTaskIndexFromList(readTaskList(), task);
    boxNotes.deleteAt(taskIndexToDelete);
  }

  void deleteAllTask() {
    boxNotes.clear();
  }

  void updateTask(TaskModel task) {
    int taskIndexToUpdate = getTaskIndexFromList(readTaskList(), task);
    boxNotes.putAt(taskIndexToUpdate, task);
  }

  int getTaskIndexFromList(List<TaskModel> tasks, TaskModel task) {
    for (var i = 0; i < tasks.length; i++) {
      if (task.id == tasks[i].id) {
        return i;
      }
    }
    return -1;
  }
}
