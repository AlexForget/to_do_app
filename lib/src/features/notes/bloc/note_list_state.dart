part of 'note_list_bloc.dart';

abstract class NoteListState {
  List<NoteModel> notes;
  NoteListState({required this.notes});
}

final class NoteListInitial extends NoteListState {
  NoteListInitial({required super.notes});
}

final class NoteListUpdated extends NoteListState {
  NoteListUpdated({required super.notes});
}
