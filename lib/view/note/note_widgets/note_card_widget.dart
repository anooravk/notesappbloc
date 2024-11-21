import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/note/note_bloc.dart';
import '../../../bloc/note/note_event.dart';
import '../../../components/text_widget.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/app_colors.dart';
import 'note_actions_widget.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({super.key, required this.note});
  final note;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.greyC1C,
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            RoutesName.detailNoteScreen,
            arguments: {
              'noteId': note['noteId'],
              'title': note['title'],
              'content': note['content'],
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                child: NoteActionsWidget(
                  onEdit: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.updateNoteScreen,
                      arguments: {
                        'noteId': note['noteId'],
                        'currentTitle': note['title'],
                        'currentContent': note['content'],
                      },
                    );
                  },
                  onDelete: () {
                    BlocProvider.of<NoteBloc>(context).add(DeleteNoteEvent(note['noteId']));
                  },
                  edit: Icons.edit,
                  delete: Icons.delete,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
