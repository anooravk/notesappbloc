import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login.dart';
import 'note_bloc.dart';
import 'note_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NotesAppBloc());
}

class NotesAppBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (context) => NoteBloc()..add(FetchNotesEvent()),
      child: MaterialApp(
        home: LoginSignUpScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
