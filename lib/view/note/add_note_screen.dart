import 'package:flutter/material.dart';
import 'package:notesappbloc/services/note/note_services.dart';
import 'package:notesappbloc/utils/app_colors.dart';

import '../../components/button_widget.dart';
import '../../components/text_widget.dart';
import '../../components/textfield_widget.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final services = FirebaseServices();

  void validateNote() {
    if (_formKey.currentState!.validate()) {
      services.saveNote(title: _titleController.text, content: _contentController.text, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const CustomText(
          text: 'Add New Note',
          weight: FontWeight.w300,
          size: 26.0,
          color: AppColors.black,
          align: TextAlign.start,
        ),
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
                onPressed: validateNote,
                title: 'Save Note',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
