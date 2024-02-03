import 'package:to_do_app/src/features/notes/data/local_db.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';

class TaskRepository {
  LocalDB localDB = LocalDB();

  List<NoteModel> fetchTask() {
    final taskList = localDB.readTaskList();
    return taskList;
  }

  void addNewTask(NoteModel task) {
    task.id = getNextIdAfterHighest();
    localDB.createNewTask(task);
  }

  void deleteTask(NoteModel task) {
    localDB.deleteTask(task);
  }

  void updateTask(NoteModel task) {
    localDB.updateTask(task);
  }

  void reorderTasks(List<NoteModel> tasks) {
    localDB.deleteAllTask();
    for (var i = 0; i < tasks.length; i++) {
      boxNotes.put(i, tasks[i]);
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
