import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesappbloc/services/note/note_services.dart';

import '../../components/text_widget.dart';
import '../../utils/app_colors.dart';

class LoginService {
  final FirebaseServices _services = FirebaseServices();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      User? user = await _services.signInWithGoogle();
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/noteScreen', (route) => false);
      } else {
        _showErrorMessage(context, 'Google sign-in failed');
      }
    } catch (e) {
      _showErrorMessage(context, 'Google sign-in error: $e');
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    try {
      User? user = await _services.signInWithApple();
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/noteScreen', (route) => false);
      } else {
        _showErrorMessage(context, 'Apple sign-in failed');
      }
    } catch (e) {
      _showErrorMessage(context, 'Apple sign-in error: $e');
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text: message,
          weight: FontWeight.bold,
          size: 14.0,
          color: AppColors.tabColor,
          align: TextAlign.center,
        ),
      ),
    );
  }
}
