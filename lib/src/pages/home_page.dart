import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/src/data/database.dart';
import 'package:to_do_app/src/localisation/string_hardcoded.dart';
import 'package:to_do_app/src/widgets/dialog_box.dart';
import 'package:to_do_app/src/widgets/to_do_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box("mybox");
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if ever first time, create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      db.updateDataBase();
    });
  }

  void safeNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.text = "";
      db.updateDataBase();
      Navigator.pop(context);
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBoxWidget(
          controller: _controller,
          onSave: safeNewTask,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateDataBase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        label: Text("Ajouter".hardcoded),
        icon: const Icon(Icons.add),
        onPressed: createNewTask,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TO DO".hardcoded,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4.0,
        shadowColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoNoteWidget(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteNote: () => deleteTask(index),
          );
        },
      ),
    );
  }
}
