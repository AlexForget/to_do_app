import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/src/features/notes/data/task_repository.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/helpers/notification_service.dart';

part 'note_list_event.dart';
part 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final TaskRepository taskRepository;
  NotificationServices notificationServices = NotificationServices();

  NoteListBloc({required this.taskRepository})
      : super(NoteListInitial(notes: const [])) {
    on<InitialNote>(_initialNote);
    on<ReorderedList>(_reorderedNote);
    on<AddNote>(_addNote);
    on<DeleteNote>(_deleteNote);
    on<UpdateNote>(_updateNote);
  }

  void _initialNote(InitialNote event, Emitter<NoteListState> emit) {
    List<NoteModel> notes = taskRepository.fetchTask();

    emit(NoteListInitial(notes: notes));
  }

  Future<void> _addNote(AddNote event, Emitter<NoteListState> emit) async {
    taskRepository.addNewTask(event.note);

    if (event.note.notification != null) {
      await notificationServices.sendNotification(event.note);
    }
    state.notes = [...state.notes, event.note];
    emit(NoteListUpdated(notes: state.notes));
  }

  void _deleteNote(DeleteNote event, Emitter<NoteListState> emit) {
    state.notes.remove(event.note);
    taskRepository.deleteTask(event.note);
    if (event.note.notification != null) {
      notificationServices.cancelNotification(event.note.id!);
    }
    emit(NoteListUpdated(notes: state.notes));
  }

  void _updateNote(UpdateNote event, Emitter<NoteListState> emit) {
    taskRepository.updateTask(event.note);

    notificationServices.updateNotification(event.note);
    emit(NoteListUpdated(notes: state.notes));
  }

  void _reorderedNote(ReorderedList event, Emitter<NoteListState> emit) async {
    int newIndex = event.newIndex;
    int oldIndex = event.oldIndex;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final note = state.notes.removeAt(oldIndex);
    state.notes.insert(newIndex, note);
    taskRepository.reorderTasks(state.notes);
    emit(NoteListUpdated(notes: state.notes));
  }
}
