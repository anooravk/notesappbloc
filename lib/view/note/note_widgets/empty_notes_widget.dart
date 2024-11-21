import 'package:flutter/material.dart';

import '../../../components/text_widget.dart';
import '../../../utils/app_colors.dart';

class EmptyNotesWidget extends StatelessWidget {
  const EmptyNotesWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        text: text,
        weight: FontWeight.w300,
        size: 14.0,
        color: AppColors.tabColor,
        align: TextAlign.center,
      ),
    );
  }
}
