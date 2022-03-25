import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class UserTask extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final bool completed;
  @HiveField(3)
  final DateTime dateAdded;
  @HiveField(4)
  final DateTime dateDue;
  @HiveField(5)
  final String color;

  UserTask(this.title, this.description,this.completed, this.dateAdded, this.dateDue, this.color);
}