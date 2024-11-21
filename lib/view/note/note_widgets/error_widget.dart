import 'package:flutter/material.dart';

import '../../../components/text_widget.dart';
import '../../../utils/app_colors.dart';

class NoteErrorWidget extends StatelessWidget {
  const NoteErrorWidget({super.key, required this.error, required this.onPressed});
  final String error;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: 'Error: $error',
            weight: FontWeight.w300,
            size: 14.0,
            color: AppColors.black,
            align: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onPressed,
            child: const CustomText(
              text: 'Retry',
              weight: FontWeight.w300,
              size: 14.0,
              color: AppColors.black,
              align: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
