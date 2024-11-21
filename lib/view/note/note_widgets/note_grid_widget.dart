import 'package:flutter/material.dart';

import 'note_card_widget.dart';

class NoteGridWidget extends StatelessWidget {
  const NoteGridWidget({super.key, required this.notes});
  final notes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteCardWidget(note: note);
        },
      ),
    );
  }
}
