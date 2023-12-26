import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/features/notes/models/note_model_box.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    on<AddNote>(_addNote);
  }

  void _addNote(
    AddNote event,
    Emitter<NoteState> emit,
  ) {
    NoteModel note = event.note;
    note.id = retreiveNextFreeId();
    boxNotes.put('key_${note.id}', note);
    emit(NoteInitial());
  }

  int retreiveNextFreeId() {
    List<NoteModel> noteModels = [];
    for (var note in boxNotes.values) {
      noteModels.add(note);
    }
    if (noteModels.isEmpty) return 1;
    List<int> ids = noteModels.map((note) => note.id!).toList();
    ids.sort();
    return ++ids.last;
  }
}
