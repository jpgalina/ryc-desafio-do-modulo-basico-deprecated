import 'package:challenge/models/task.dart';
import 'package:flutter/material.dart';

class TaskList extends ChangeNotifier {
  List<Task> tasks = [];

  List<Task> get _tasks {
    return [...tasks];
  }

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void saveTask(Map<String, Object> data) {
    final hasDescription = data['description'] != null;
    final task = Task(
      title: data['title'] as String,
      description: hasDescription ? data['description'] as String : '',
      dueDate: data['dueDate'] as DateTime,
    );

    addTask(task);
  }
}
