import 'package:flutter/material.dart';
import 'package:notesappbloc/routes/routes_name.dart';
import 'package:notesappbloc/utils/app_colors.dart';

import '../components/text_widget.dart';
import '../view/view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.addNoteScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const AddNotePage());

      case RoutesName.noteScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const NoteScreen());

      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (BuildContext context) => LoginSignUpScreen());
      case RoutesName.detailNoteScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => NoteDetailScreen(
            noteId: args['noteId'],
            title: args['title'],
            content: args['content'],
          ),
        );
      case RoutesName.updateNoteScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => UpdateNote(
            noteId: args['noteId'],
            currentTitle: args['currentTitle'],
            currentContent: args['currentContent'],
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: CustomText(
                text: 'No route defined',
                weight: FontWeight.w500,
                size: 16.0,
                color: AppColors.black,
                align: TextAlign.center,
              ),
            ),
          );
        });
    }
  }
}
