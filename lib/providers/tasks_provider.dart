import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/models/task_model.dart';

class TasksProvider extends ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  Future<void> getTasks() async {
    var box = await Hive.openBox<TaskModel>('tasksBox');
    _tasks = box.values.toList();
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    var box = await Hive.openBox<TaskModel>('tasksBox');
    await box.put('${task.savedDate}', task);
    _tasks = box.values.toList();
    notifyListeners();
  }

  Future<void> updateTask(int index,TaskModel task) async {
    var box = await Hive.openBox<TaskModel>('tasksBox');
    bool taskExists = box.containsKey(task.savedDate);
    if(taskExists) {
      await box.putAt(index, task);
      _tasks = box.values.toList();
      notifyListeners();
    } else {
      await box.put('${task.savedDate}', task);
      _tasks = box.values.toList();
      notifyListeners();
    }

  }

  Future<void> removeTask(TaskModel task) async {
    var box = await Hive.openBox<TaskModel>('tasksBox');
    await box.delete('${task.savedDate}');
    _tasks = box.values.toList();
    notifyListeners();
  }
}