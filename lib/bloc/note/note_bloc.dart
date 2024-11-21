import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  late final StreamSubscription<QuerySnapshot> _noteSubscription;

  NoteBloc() : super(NoteInitial()) {
    on<FetchNotesEvent>(_onFetchNotes);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  void _onFetchNotes(FetchNotesEvent event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        emit(NoteError('User not authenticated'));
        return;
      }
      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('notes').snapshots().listen(
        (snapshot) {
          emit(NoteLoaded(snapshot.docs));
        },
        onError: (e) {
          emit(NoteError(e.toString()));
        },
      ).asFuture();
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  void _onDeleteNote(DeleteNoteEvent event, Emitter<NoteState> emit) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        emit(NoteError('User not authenticated'));
        return;
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('notes').doc(event.noteId).delete();

      emit(NoteLoading());
      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('notes').get().then((snapshot) {
        emit(NoteLoaded(snapshot.docs));
      });
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _noteSubscription.cancel();
    return super.close();
  }
}
