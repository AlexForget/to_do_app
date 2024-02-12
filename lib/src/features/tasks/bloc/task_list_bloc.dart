import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/src/features/tasks/data/task_repository.dart';
import 'package:to_do_app/src/features/tasks/models/task_model.dart';
import 'package:to_do_app/src/helpers/notification_service.dart';
import 'package:to_do_app/src/helpers/time_comparaison.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskRepository taskRepository = TaskRepository();
  NotificationServices notificationServices = NotificationServices();
  TaskListBloc() : super(TaskListInitial(tasks: const [])) {
    on<InitialTask>(_initialNote);
    on<ReorderedList>(_reorderedNote);
    on<AddTask>(_addNote);
    on<DeleteTask>(_deleteNote);
    on<UpdateTask>(_updateNote);
  }

  void _initialNote(InitialTask event, Emitter<TaskListState> emit) {
    List<TaskModel> notes = taskRepository.fetchTask();
    emit(TaskListInitial(tasks: notes));
  }

  Future<void> _addNote(AddTask event, Emitter<TaskListState> emit) async {
    state.tasks = [...state.tasks, event.task];
    taskRepository.addNewTask(event.task);
    if (event.task.notification != null) {
      notificationServices.sendNotification(event.task);
    }
    emit(TaskListUpdated(tasks: state.tasks));
  }

  Future<void> _updateNote(
      UpdateTask event, Emitter<TaskListState> emit) async {
    taskRepository.updateTask(event.task);

    if (event.task.notification != null && event.task.completed) {
      notificationServices.cancelNotification(event.task.id);
    } else if (event.task.notification != null &&
        TimeOfDay.fromDateTime(event.task.notification!)
            .compareTo(TimeOfDay.now())) {
      notificationServices.sendNotification(event.task);
    }
    emit(TaskListUpdated(tasks: state.tasks));
  }

  void _deleteNote(DeleteTask event, Emitter<TaskListState> emit) {
    state.tasks.remove(event.task);
    taskRepository.deleteTask(event.task);
    if (event.task.notification != null) {
      notificationServices.cancelNotification(event.task.id);
    }
    emit(TaskListUpdated(tasks: state.tasks));
  }

  void _reorderedNote(ReorderedList event, Emitter<TaskListState> emit) async {
    int newIndex = event.newIndex;
    int oldIndex = event.oldIndex;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final note = state.tasks.removeAt(oldIndex);
    state.tasks.insert(newIndex, note);
    taskRepository.reorderTasks(state.tasks);
    emit(TaskListUpdated(tasks: state.tasks));
  }
}
