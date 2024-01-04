import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/features/notes/models/note_model_box.dart';
import 'package:to_do_app/src/helpers/constants.dart';

part 'note_list_event.dart';
part 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc() : super(NoteListInitial(notes: const [])) {
    on<InitialNote>(_initialNote);
    on<ReorderedList>(_reorderedNote);
    on<AddNote>(_addNote);
    on<DeleteNote>(_deleteNote);
    on<UpdateNote>(_updateNote);
  }

  void _initialNote(InitialNote event, Emitter<NoteListState> emit) {
    final box = Hive.box<NoteModel>(noteHiveBox);
    List<NoteModel> notes = box.values.toList();
    emit(NoteListInitial(notes: notes));
  }

  void _reorderedNote(ReorderedList event, Emitter<NoteListState> emit) async {
    int newIndex = event.newIndex;
    int oldIndex = event.oldIndex;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final note = state.notes.removeAt(oldIndex);
    state.notes.insert(newIndex, note);
    await boxNotes.clear();
    for (var i = 0; i < state.notes.length; i++) {
      boxNotes.put(i, state.notes[i]);
    }
    emit(NoteListUpdated(notes: state.notes));
  }

  void _addNote(AddNote event, Emitter<NoteListState> emit) {
    event.note.id = getNextAfterHighest(state.notes);
    state.notes = [...state.notes, event.note];
    boxNotes.add(event.note);
    emit(NoteListUpdated(notes: state.notes));
  }

  void _deleteNote(DeleteNote event, Emitter<NoteListState> emit) {
    int indexToDelete = getNoteIndexFromList(state.notes, event.note);
    state.notes.remove(event.note);
    boxNotes.deleteAt(indexToDelete);
    emit(NoteListUpdated(notes: state.notes));
  }

  void _updateNote(UpdateNote event, Emitter<NoteListState> emit) {
    int noteToUpdate = getNoteIndexFromList(state.notes, event.note);
    boxNotes.putAt(noteToUpdate, event.note);
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

  int getNoteIndexFromList(List<NoteModel> notes, NoteModel note) {
    for (var i = 0; i < notes.length; i++) {
      if (note.id == notes[i].id) {
        return i;
      }
    }
    return -1;
  }
}
