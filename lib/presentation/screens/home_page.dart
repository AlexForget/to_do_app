import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/helpers/app_sizes.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/helpers/constants.dart';
import 'package:to_do_app/presentation/widgets/custom_dialog_box.dart';
import 'package:to_do_app/presentation/widgets/to_do_note.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box(myHiveBoxName);
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if ever first time, create default data
    if (_myBox.get(toDoListName) == null) {
      db.createInitialData(AppLocalizations.of(context)!.defaultNote);
    } else {
      db.loadData();
    }
    super.initState();
  }

  TextEditingController _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      db.updateDataBase();
    });
  }

  void safeNewTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        db.toDoList.add([_controller.text, false]);
        _controller.text = "";
        db.updateDataBase();
      });
    }
    Navigator.pop(context);
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          controller: _controller,
          onSave: safeNewTask,
          onCancel: () => {
            Navigator.pop(context),
            _controller.text = "",
          },
          title: AppLocalizations.of(context)!.newNote,
          hint: AppLocalizations.of(context)!.addNewNote,
        );
      },
    );
  }

  void editTask(int index) {
    _controller = getTaskText(index);
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          controller: _controller,
          onSave: () => {
            updateEditTask(index),
            Navigator.pop(context),
          },
          onCancel: () => {
            _controller.text = "",
            Navigator.pop(context),
          },
          title: AppLocalizations.of(context)!.modifyNote,
        );
      },
    );
  }

  void updateEditTask(int index) {
    setState(() {
      db.toDoList[index] = [_controller.text, false];
      _controller.text = "";
      db.updateDataBase();
    });
  }

  void confirmDeleteTask(index) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          onSave: () => {
            deleteTask(index),
            Navigator.pop(context),
          },
          onCancel: () => Navigator.pop(context),
          title: AppLocalizations.of(context)!.deleteNote,
          message: AppLocalizations.of(context)!.confirmDeleteNote,
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

  TextEditingController getTaskText(int index) {
    TextEditingController temp = TextEditingController();
    temp.text = db.toDoList.elementAt(index)[0];
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        label: Text(AppLocalizations.of(context)!.add),
        icon: const Icon(Icons.add),
        onPressed: createNewTask,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.title,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4.0,
        shadowColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: Sizes.p64),
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoNoteWidget(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteNote: () => confirmDeleteTask(index),
            editNote: () => editTask(index),
          );
        },
      ),
    );
  }
}
