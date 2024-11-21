import 'package:flutter/material.dart';
import 'package:notesappbloc/services/note/note_services.dart';
import 'package:notesappbloc/utils/app_colors.dart';

import '../../components/button_widget.dart';
import '../../components/textfield_widget.dart';

class UpdateNote extends StatefulWidget {
  final String noteId;
  final String currentTitle;
  final String currentContent;

  const UpdateNote({
    super.key,
    required this.noteId,
    required this.currentTitle,
    required this.currentContent,
  });

  @override
  _UpdateNoteState createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.currentTitle;
    _contentController.text = widget.currentContent;
  }

  final services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextField(
                controller: _titleController,
                labelText: 'Title',
                maxlines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _contentController,
                labelText: 'Content',
                maxlines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content for your note';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                bgColor: AppColors.tabColor,
                textColor: AppColors.white,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    services.updateNote(title: _titleController.text, content: _contentController.text, noteId: widget.noteId, context: context);
                  }
                },
                title: 'Save Changes',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
