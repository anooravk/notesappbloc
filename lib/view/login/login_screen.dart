import 'package:flutter/material.dart';

import '../../components/button_widget.dart';
import '../../components/text_widget.dart';
import '../../services/login/login_service.dart';
import '../../utils/app_colors.dart';

class LoginSignUpScreen extends StatelessWidget {
  final LoginService _loginService = LoginService();

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
                onPressed: () => _loginService.signInWithGoogle(context),
                title: "Sign in with Google",
              ),
              const SizedBox(height: 20),
              CustomButton(
                bgColor: AppColors.tabColor,
                textColor: AppColors.white,
                onPressed: () => _loginService.signInWithApple(context),
                title: "Sign in with Apple",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
