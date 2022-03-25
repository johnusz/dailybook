part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}

class InitNoteEvent extends NoteEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoadNoteEvent extends NoteEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AddNoteEvent extends NoteEvent{
  final String title;
  final String desc;
  final DateTime dateTime;
  final String color;

  AddNoteEvent(this.title, this.desc, this.dateTime, this.color);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class UpdateNoteEvent extends NoteEvent{
  final String title;
  final String desc;
  final DateTime dateTime;
  final String color;

  UpdateNoteEvent(this.title, this.desc, this.dateTime, this.color);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class RemoveNoteEvent extends NoteEvent{
  final DateTime time;

  RemoveNoteEvent(this.time);

  @override
  // TODO: implement props
  List<Object?> get props => [time];

}
