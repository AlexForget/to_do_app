part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

class AddNote extends NoteEvent {}

class UpdateNote extends NoteEvent {}

class RemoveNote extends NoteEvent {}
