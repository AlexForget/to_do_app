import 'package:hive/hive.dart';
import 'package:to_do_app/src/helpers/constants.dart';

class ToDoDataBase {
  List toDoList = [];

  final _myBox = Hive.box(myHiveBoxName);

  void createInitialData(String note) {
    toDoList = [
      [note, false]
    ];
  }

  void loadData() {
    toDoList = _myBox.get(toDoListName);
  }

  void updateDataBase() {
    _myBox.put(toDoListName, toDoList);
  }
}
