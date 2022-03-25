import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dailybook/models/note_model.dart';
import 'package:equatable/equatable.dart';

import '../services/notesservice.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesService _notesService;

  NoteBloc(this._notesService) : super(NoteInitial()) {
    on<InitNoteEvent>((event, emit) async{
      await _notesService.init();

      final notes = _notesService.getNotes();
      emit(NoteLoadedState(notes));
    });
    on<LoadNoteEvent>((event, emit) async{
      final notes = _notesService.getNotes();
      emit(NoteLoadedState(notes));
    });
    on<AddNoteEvent>((event, emit) {
      _notesService.addNote(event.title, event.desc, event.dateTime, event.color);
      add(LoadNoteEvent());
    });

    on<RemoveNoteEvent>((event, emit) {
      _notesService.removeNote(event.time);
      add(LoadNoteEvent());
    });
    on<UpdateNoteEvent>((event, emit){
      _notesService.updateNote(event.title, event.desc, event.dateTime, event.color);
      add(LoadNoteEvent());
    });
  }
}
