import 'package:hive_flutter/hive_flutter.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String submitDate;
  @HiveField(4)
  final String goalDate;
  @HiveField(5)
  final bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.submitDate,
    required this.goalDate,
    required this.isDone,
  });
}
// flutter packages pub run build_runner build