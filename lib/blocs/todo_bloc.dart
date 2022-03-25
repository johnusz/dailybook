import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dailybook/models/note_model.dart';
import 'package:dailybook/models/task_model.dart';
import 'package:dailybook/screens/todoslist.dart';
import 'package:dailybook/services/notesservice.dart';
import 'package:dailybook/services/taskservice.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TasksService _tasksService;


  TodoBloc(this._tasksService) : super(TodoInitial()) {
    on<InitTodoEvent>((event, emit) async{
      await _tasksService.init();
      final tasks = _tasksService.getTasks();
      emit(TodoLoadedState(tasks));
    });

    on<LoadTodoEvent>((event, emit) async{
      final tasks = _tasksService.getTasks();
      emit(TodoLoadedState(tasks));
    });
    on<AddTodoEvent>((event, emit) async{
      _tasksService.addTask(event.title, event.desc, DateTime.now(), event.due, event.color);
      add(LoadTodoEvent());
    });
    on<RemoveTodoEvent>((event, emit){
      _tasksService.removeTask(event.time);
      add(LoadTodoEvent());
    });

  }


}
