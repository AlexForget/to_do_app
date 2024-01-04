// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_list_bloc.dart';

@immutable
abstract class NoteListEvent {}

class InitialNote extends NoteListEvent {}

class ReorderedList extends NoteListEvent {
  final NoteModel note;
  final int oldIndex;
  final int newIndex;
  ReorderedList(
      {required this.note, required this.oldIndex, required this.newIndex});
}

class AddNote extends NoteListEvent {
  final NoteModel note;
  AddNote({required this.note});
}

class UpdateNote extends NoteListEvent {
  final NoteModel note;
  UpdateNote({required this.note});
}

class DeleteNote extends NoteListEvent {
  final NoteModel note;
  DeleteNote({required this.note});
}
