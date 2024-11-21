import 'package:flutter/material.dart';
import 'package:notesappbloc/text_widget.dart';

import 'app_colors.dart';

class NoteDetailScreen extends StatelessWidget {
  final String noteId;
  final String title;
  final String content;

  NoteDetailScreen({required this.noteId, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: CustomText(
          text: title,
          weight: FontWeight.bold,
          size: 25.0,
          color: AppColors.white,
          align: TextAlign.center,
        ),
        backgroundColor: AppColors.tabColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Title:',
              weight: FontWeight.bold,
              size: 20.0,
              color: AppColors.black,
              align: TextAlign.left,
            ),
            SizedBox(height: 10),
            CustomText(
              text: title,
              weight: FontWeight.w400,
              size: 18.0,
              color: AppColors.black,
              align: TextAlign.left,
            ),
            SizedBox(height: 20),
            CustomText(
              text: 'Content:',
              weight: FontWeight.bold,
              size: 20.0,
              color: AppColors.black,
              align: TextAlign.left,
            ),
            SizedBox(height: 10),
            CustomText(
              text: content,
              weight: FontWeight.w300,
              size: 16.0,
              color: AppColors.black,
              align: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
