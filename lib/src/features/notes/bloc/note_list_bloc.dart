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
    event.note.id = getNextAfterHighest(state.notes);
    state.notes = [...state.notes, event.note];
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

  int getNextAfterHighest(List<NoteModel> notes) {
    if (notes.isEmpty) return 0;

    List<int> notesId = [];
    for (var note in notes) {
      notesId.add(note.id!);
    }
    notesId.sort();
    int highest = notesId.last;
    int nextAfterHighest = highest + 1;
    return nextAfterHighest;
  }
}
