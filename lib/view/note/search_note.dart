import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesappbloc/view/view.dart';

import '../../bloc/note/note_bloc.dart';
import '../../bloc/note/note_state.dart';
import '../../components/text_widget.dart';
import '../../utils/app_colors.dart';

class NoteSearchDelegate extends SearchDelegate {
  final NoteBloc noteBloc;

  NoteSearchDelegate({required this.noteBloc});

  @override
  String get searchFieldLabel => 'Search notes by title or content';

  @override
  Widget buildSuggestions(BuildContext context) {
    final query = this.query;

    return BlocBuilder<NoteBloc, NoteState>(
      bloc: noteBloc,
      builder: (context, state) {
        if (state is NoteLoaded) {
          final filteredNotes = state.notes.where((note) {
            final title = note['title'].toLowerCase();
            final content = note['content'].toLowerCase();
            final searchQuery = query.toLowerCase();

            return title.contains(searchQuery) || content.contains(searchQuery);
          }).toList();

          return Container(
            color: AppColors.white,
            child: ListView.builder(
              itemCount: filteredNotes.length,
              itemBuilder: (context, index) {
                final note = filteredNotes[index];
                return ListTile(
                  title: CustomText(
                    text: note['title'],
                    weight: FontWeight.bold,
                    size: 16.0,
                    color: AppColors.black,
                    align: TextAlign.start,
                  ),
                  subtitle: CustomText(
                    text: note['content'],
                    weight: FontWeight.w300,
                    size: 13.0,
                    color: AppColors.black,
                    align: TextAlign.start,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailScreen(
                          noteId: note['noteId'],
                          title: note['title'],
                          content: note['content'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }

        return const Center(
          child: CustomText(
            text: 'No notes found',
            weight: FontWeight.w300,
            size: 16.0,
            color: AppColors.black,
            align: TextAlign.start,
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isEmpty) {
      return [];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
      ];
    }
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }
}
