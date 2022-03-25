import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 2)
class UserNote extends HiveObject{
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final DateTime dateAdded;
  @HiveField(3)
  final String color;

  UserNote(this.title, this.description, this.dateAdded, this.color);
}