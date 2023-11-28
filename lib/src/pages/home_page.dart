import 'package:flutter/material.dart';
import 'package:to_do_app/src/localisation/string_hardcoded.dart';
import 'package:to_do_app/src/widgets/note_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TO DO".hardcoded,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        children: const [
          NoteWidget(),
          NoteWidget(),
          NoteWidget(),
          NoteWidget(),
          NoteWidget(),
          NoteWidget(),
          NoteWidget(),
          NoteWidget(),
          NoteWidget(),
          NoteWidget(),
          NoteWidget(),
          NoteWidget(),
        ],
      ),
    );
  }
}
