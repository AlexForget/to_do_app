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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        label: Text("Ajouter".hardcoded),
        icon: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Nouvelle note".hardcoded),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Annuler".hardcoded),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Enregistrer".hardcoded),
              ),
            ],
            content: const TextField(
              minLines: 1,
              maxLines: 5,
            ),
          ),
        ),
      ),
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
