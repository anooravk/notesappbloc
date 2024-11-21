import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesappbloc/note_screen.dart';
import 'package:notesappbloc/services.dart';
import 'package:notesappbloc/text_widget.dart';

import 'app_colors.dart';
import 'button_widget.dart';

class LoginSignUpScreen extends StatelessWidget {
  final services = FirebaseServices();

  LoginSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const CustomText(
          text: 'Login / Sign Up',
          weight: FontWeight.bold,
          size: 25.0,
          color: AppColors.tabColor,
          align: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                  bgColor: AppColors.tabColor,
                  textColor: AppColors.white,
                  onPressed: () async {
                    User? user = await services.signInWithGoogle();
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NoteScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: CustomText(
                            text: 'Google sign-in failed',
                            weight: FontWeight.bold,
                            size: 14.0,
                            color: AppColors.tabColor,
                            align: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
                  title: "Sign in with Google"),
              const SizedBox(height: 20),
              CustomButton(
                  bgColor: AppColors.tabColor,
                  textColor: AppColors.white,
                  onPressed: () async {
                    User? user = await services.signInWithApple();
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NoteScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: CustomText(
                            text: 'Apple sign-in failed',
                            weight: FontWeight.bold,
                            size: 14.0,
                            color: AppColors.tabColor,
                            align: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
                  title: "Sign in with Apple"),
            ],
          ),
        ),
      ),
    );
  }
}
