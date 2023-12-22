import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

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
    emit(NoteInitial());
  }
}
