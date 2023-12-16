import 'package:hive/hive.dart';
import 'package:to_do_app/src/helpers/constants.dart';

class ToDoDataBase {
  List toDoList = [];

  final _myBox = Hive.box(MY_HIVE_BOX_NAME);

  void createInitialData(String note) {
    toDoList = [
      [note, false]
    ];
  }

  void loadData() {
    toDoList = _myBox.get(TODO_LIST_NAME);
  }

  void updateDataBase() {
    _myBox.put(TODO_LIST_NAME, toDoList);
  }
}
