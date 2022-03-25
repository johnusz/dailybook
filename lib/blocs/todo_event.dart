part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class InitTodoEvent extends TodoEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];


}


class LoadTodoEvent extends TodoEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class RemoveTodoEvent extends TodoEvent{
  final DateTime time;

  RemoveTodoEvent(this.time);

  @override
  // TODO: implement props
  List<Object?> get props => [time];

}

class AddTodoEvent extends TodoEvent{
  final String title;
  final String desc;
  final DateTime due;
  final String color;

  AddTodoEvent(this.title, this.desc, this.due, this.color);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}