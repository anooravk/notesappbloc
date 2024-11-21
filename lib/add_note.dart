import 'package:flutter/material.dart';
import 'package:notesappbloc/app_colors.dart';
import 'package:notesappbloc/button_widget.dart';
import 'package:notesappbloc/services.dart';
import 'package:notesappbloc/text_widget.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: CustomText(
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
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content for your note';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                bgColor: AppColors.tabColor,
                textColor: AppColors.white,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    services.saveNote(title: _titleController.text, content: _contentController.text, context: context);
                  }
                },
                title: 'Save Note',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
