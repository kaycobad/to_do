import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final bool completed;
  @HiveField(2)
  final int savedDate;

  TaskModel({
    required this.title,
    this.completed = false,
    required this.savedDate,
  });
}