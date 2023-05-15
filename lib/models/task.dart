import 'dart:math';
class Task {
  String id = Random().nextDouble().toString();
  String title;
  String? description;
  DateTime dueDate;
  bool renderedLife = false;
  bool isCompleted = false;

  Task({
    required this.title,
    this.description,
    required this.dueDate,
  });
}