import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesappbloc/add_note.dart';
import 'package:notesappbloc/note_bloc.dart';
import 'package:notesappbloc/note_event.dart';
import 'package:notesappbloc/note_state.dart';
import 'package:notesappbloc/search_note.dart';
import 'package:notesappbloc/text_widget.dart';
import 'package:notesappbloc/update_note.dart';

import 'app_colors.dart';
import 'detail_note.dart';

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: AppColors.white,
                  size: 30,
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: NoteSearchDelegate(
                      noteBloc: BlocProvider.of<NoteBloc>(context),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NoteLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    final note = state.notes[index];
                    return InkWell(
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
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.greyC1C,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: note['title'],
                              weight: FontWeight.bold,
                              size: 18.0,
                              color: AppColors.white,
                              align: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              text: note['content'],
                              weight: FontWeight.w300,
                              size: 14.0,
                              color: AppColors.white,
                              align: TextAlign.center,
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdateNote(
                                            noteId: note['noteId'],
                                            currentTitle: note['title'],
                                            currentContent: note['content'],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      BlocProvider.of<NoteBloc>(context).add(DeleteNoteEvent(note['noteId']));
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is NoteError) {
              return Center(
                child: CustomText(
                  text: 'Error: ${state.error}',
                  weight: FontWeight.w300,
                  size: 14.0,
                  color: AppColors.white,
                  align: TextAlign.center,
                ),
              );
            }
            return const Center(
              child: CustomText(
                text: 'No notes available',
                weight: FontWeight.w300,
                size: 14.0,
                color: AppColors.tabColor,
                align: TextAlign.center,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNotePage()),
            );
          },
          backgroundColor: AppColors.tabColor,
          child: const Icon(
            Icons.add,
            size: 30,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
