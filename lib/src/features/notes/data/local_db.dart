import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/helpers/constants.dart';

late Box boxNotes;

class LocalDB {
  LocalDB();

  List<NoteModel> readTaskList() {
    final box = Hive.box<NoteModel>(noteHiveBox);
    return box.values.toList();
  }

  void createNewTask(NoteModel task) {
    boxNotes.add(task);
  }

  void deleteTask(NoteModel task) {
    int taskIndexToDelete = getNoteIndexFromList(readTaskList(), task);
    boxNotes.deleteAt(taskIndexToDelete);
  }

  void deleteAllTask() {
    boxNotes.clear();
  }

  void updateTask(NoteModel task) {
    int taskIndexToUpdate = getNoteIndexFromList(readTaskList(), task);
    boxNotes.putAt(taskIndexToUpdate, task);
  }

  int getNoteIndexFromList(List<NoteModel> notes, NoteModel note) {
    for (var i = 0; i < notes.length; i++) {
      if (note.id == notes[i].id) {
        return i;
      }
    }
    return -1;
  }
}
