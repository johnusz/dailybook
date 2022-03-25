part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();
}

class NoteInitial extends NoteState {
  @override
  List<Object> get props => [];
}

class NoteLoadedState extends NoteState{

  final List<UserNote> notes;

  NoteLoadedState(this.notes);
  @override
  // TODO: implement props
  List<Object?> get props => [notes];

}