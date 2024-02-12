// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_list_bloc.dart';

@immutable
abstract class TaskListEvent {}

class InitialTask extends TaskListEvent {}

class ReorderedList extends TaskListEvent {
  final int oldIndex;
  final int newIndex;
  ReorderedList({required this.oldIndex, required this.newIndex});
}

class AddTask extends TaskListEvent {
  final TaskModel task;
  AddTask({required this.task});
}

class UpdateTask extends TaskListEvent {
  final TaskModel task;
  UpdateTask({required this.task});
}

class DeleteTask extends TaskListEvent {
  final TaskModel task;
  DeleteTask({required this.task});
}
