import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/helpers/constants.dart';

late Box boxNotes;

class LocalDB {
  LocalDB();

  List<NoteModel> getTaskList() {
    final box = Hive.box<NoteModel>(noteHiveBox);
    return box.values.toList();
  }
}
