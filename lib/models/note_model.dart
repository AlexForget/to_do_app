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
}
