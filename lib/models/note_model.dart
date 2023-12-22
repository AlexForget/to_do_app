// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoteModel {
  final int id;
  final String description;
  final bool completed;
  final DateTime? notification;

  NoteModel({
    required this.id,
    required this.description,
    required this.completed,
    this.notification,
  });

  NoteModel copyWith({
    int? id,
    String? description,
    bool? completed,
    DateTime? notification,
  }) {
    return NoteModel(
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

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      description: map['description'] as String,
      completed: map['completed'] as bool,
      notification: map['notification'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['notification'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel(id: $id, description: $description, completed: $completed, notification: $notification)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
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
