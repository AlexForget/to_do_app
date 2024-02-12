part of 'task_list_bloc.dart';

abstract class TaskListState {
  List<TaskModel> tasks;
  TaskListState({required this.tasks});
}

final class TaskListInitial extends TaskListState {
  TaskListInitial({required super.tasks});
}

final class TaskListUpdated extends TaskListState {
  TaskListUpdated({required super.tasks});
}
