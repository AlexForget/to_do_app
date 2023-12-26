// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

class AddNote extends NoteEvent {
  final NoteModel note;
  AddNote({
    required this.note,
  });
}

class UpdateNote extends NoteEvent {}

class RemoveNote extends NoteEvent {}
