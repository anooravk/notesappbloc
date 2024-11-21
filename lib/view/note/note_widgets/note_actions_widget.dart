import 'package:flutter/material.dart';

class NoteActionsWidget extends StatelessWidget {
  const NoteActionsWidget({super.key, required this.onEdit, required this.onDelete, required this.edit, required this.delete});
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final IconData edit;
  final IconData delete;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(edit),
          onPressed: onEdit,
        ),
        IconButton(
          icon: Icon(delete),
          onPressed: onDelete,
        ),
      ],
    );
  }
}
