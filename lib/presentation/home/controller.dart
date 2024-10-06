import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:todo/models/taskModel.dart';

class TaskController {
  final ValueNotifier<List<Task>> tasks = ValueNotifier<List<Task>>([]);

  TaskController() {
    _loadTasks();
  }

  void _loadTasks() {
    final taskBox = Hive.box('tasksBox');
    tasks.value = taskBox.values.cast<Task>().toList();
  }

  void addTask(String title) {
    final task = Task(title: title);
    final taskBox = Hive.box('tasksBox');
    taskBox.add(task);
    tasks.value = taskBox.values.cast<Task>().toList();
  }

  void toggleTaskCompletion(int index) {
    final taskBox = Hive.box('tasksBox');
    final task = taskBox.getAt(index) as Task;
    task.isCompleted = !task.isCompleted;
    taskBox.putAt(index, task);
    tasks.value = taskBox.values.cast<Task>().toList();
  }

  void deleteTask(int index) {
    final taskBox = Hive.box('tasksBox');
    taskBox.deleteAt(index);
    tasks.value = taskBox.values.cast<Task>().toList();
  }
}
