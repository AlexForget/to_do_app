part of 'note_bloc.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoading extends NoteState {}

final class NoteLoaded extends NoteState {}

final class NoteError extends NoteState {
  final String description;

  NoteError(this.description);
}
