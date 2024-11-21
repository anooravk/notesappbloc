import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesappbloc/routes/routes.dart';
import 'package:notesappbloc/routes/routes_name.dart';

import 'bloc/note/note_bloc.dart';
import 'bloc/note/note_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const NotesAppBloc());
}

class NotesAppBloc extends StatelessWidget {
  const NotesAppBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (context) => NoteBloc()..add(FetchNotesEvent()),
      child: const MaterialApp(
        initialRoute: RoutesName.loginScreen,
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
