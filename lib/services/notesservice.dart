import 'package:dailybook/models/note_model.dart';
import 'package:dailybook/models/task_model.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class NotesService{
  late Box<UserNote> _notes;

  Future<void> init() async {
    Hive.registerAdapter(UserNoteAdapter());
    _notes = await Hive.openBox<UserNote>('notes');

  }

  List<UserNote> getNotes(){
    final tasks = _notes.values.toList();
    return tasks;
  }

  void addNote(final String title, description, final DateTime dateCreated, String color){
    _notes.add(UserNote(title, description, dateCreated, color));
  }

  Future<void> updateNote(final String titl, desc, DateTime added, String color) async {

    final noteToEdit = _notes.values.firstWhere((element) => element.dateAdded == added);
    final index = noteToEdit.key as int;
    await _notes.put(index, UserNote(titl, desc, added, color));
  }
  
  Future<void> removeNote(final DateTime date) async {
    final noteToRemove = _notes.values.firstWhere((element) => element.dateAdded == date);
    await noteToRemove.delete();
  }

}