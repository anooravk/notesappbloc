import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesappbloc/bloc/note/note_state.dart';
import 'package:notesappbloc/view/note/note_widgets/empty_notes_widget.dart';
import 'package:notesappbloc/view/note/note_widgets/error_widget.dart';
import 'package:notesappbloc/view/note/search_note.dart';

import '../../bloc/note/note_bloc.dart';
import '../../bloc/note/note_event.dart';
import '../../components/text_widget.dart';
import '../../routes/routes_name.dart';
import '../../utils/app_colors.dart';
import 'note_widgets/note_grid_widget.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc()..add(FetchNotesEvent()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: const CustomText(
            text: 'My Notes',
            weight: FontWeight.bold,
            size: 25.0,
            color: AppColors.white,
            align: TextAlign.center,
          ),
          backgroundColor: AppColors.tabColor,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: AppColors.white, size: 30),
              onPressed: () => showSearch(
                context: context,
                delegate: NoteSearchDelegate(
                  noteBloc: BlocProvider.of<NoteBloc>(context),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NoteLoaded) {
              return NoteGridWidget(notes: state.notes);
            } else if (state is NoteError) {
              return NoteErrorWidget(
                error: state.error,
                onPressed: () => BlocProvider.of<NoteBloc>(context).add(
                  FetchNotesEvent(),
                ),
              );
            }
            return const EmptyNotesWidget(
              text: 'No notes available',
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, RoutesName.addNoteScreen),
          backgroundColor: AppColors.tabColor,
          child: const Icon(Icons.add, size: 30, color: AppColors.white),
        ),
      ),
    );
  }
}
