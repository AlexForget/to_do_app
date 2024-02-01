import 'package:to_do_app/src/features/notes/data/local_db.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';

class TaskRepository {
  LocalDB localDB = LocalDB();
  List<NoteModel> fetchTask() {
    final taskList = localDB.getTaskList();
    return taskList;
  }

  getSomething() {
    return 'text';
  }

  getTaskList() {}
}
