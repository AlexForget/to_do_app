import 'package:hive/hive.dart';
import 'package:to_do_app/src/localisation/string_hardcoded.dart';

class ToDoDataBase {
  List toDoList = [];

  final _myBox = Hive.box("mybox");

  void createInitialData() {
    toDoList = [
      ["Default Note".hardcoded, false]
    ];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
