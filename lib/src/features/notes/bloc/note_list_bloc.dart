import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';

part 'note_list_event.dart';
part 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc() : super(NoteListInitial(notes: const [])) {
    on<AddNote>(_addNote);
    on<DeleteNote>(_deleteNote);
    on<UpdateNote>(_updateNote);
  }

  void _addNote(AddNote event, Emitter<NoteListState> emit) {
    state.notes = [...state.notes, event.note];
    //state.notes.add(event.note);
    emit(NoteListUpdated(notes: state.notes));
  }

  void _deleteNote(DeleteNote event, Emitter<NoteListState> emit) {
    state.notes.remove(event.note);
    emit(NoteListUpdated(notes: state.notes));
  }

  void _updateNote(UpdateNote event, Emitter<NoteListState> emit) {
    for (var i = 0; i < state.notes.length; i++) {
      if (event.note.id == state.notes[i].id) {
        state.notes[i] = event.note;
      }
    }
    emit(NoteListUpdated(notes: state.notes));
  }
}
