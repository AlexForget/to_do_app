import 'package:to_do_app/src/features/tasks/data/local_db.dart';
import 'package:to_do_app/src/features/tasks/models/task_model.dart';

class TaskRepository {
  LocalDB localDB = LocalDB();

  List<TaskModel> fetchTask() {
    final taskList = localDB.readTaskList();
    return taskList;
  }

  void addNewTask(TaskModel task) {
    task.id = getNextIdAfterHighest();
    localDB.createNewTask(task);
  }

  void deleteTask(TaskModel task) {
    localDB.deleteTask(task);
  }

  void updateTask(TaskModel task) {
    localDB.updateTask(task);
  }

  void reorderTasks(List<TaskModel> tasks) {
    for (var i = 0; i < tasks.length; i++) {
      localDB.deleteTask(tasks[i]);
    }
    for (var i = 0; i < tasks.length; i++) {
      localDB.createNewTask(tasks[i]);
    }
  }

  int getNextIdAfterHighest() {
    final tasks = fetchTask();

    if (tasks.isEmpty) return 0;

    List<int> tasksId = [];
    for (var task in tasks) {
      tasksId.add(task.id!);
    }
    tasksId.sort();
    int highest = tasksId.last;
    int nextAfterHighest = highest + 1;
    return nextAfterHighest;
  }
}
