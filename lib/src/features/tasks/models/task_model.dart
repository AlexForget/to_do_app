// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool completed;

  @HiveField(3)
  DateTime? notification;

  TaskModel({
    this.id,
    required this.description,
    required this.completed,
    this.notification,
  });

  TaskModel copyWith({
    int? id,
    String? description,
    bool? completed,
    DateTime? notification,
  }) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      notification: notification ?? this.notification,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'completed': completed,
      'notification': notification?.millisecondsSinceEpoch,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int,
      description: map['description'] as String,
      completed: map['completed'] as bool,
      notification: map['notification'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['notification'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, description: $description, completed: $completed, notification: $notification)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.completed == completed &&
        other.notification == notification;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        completed.hashCode ^
        notification.hashCode;
  }
}
