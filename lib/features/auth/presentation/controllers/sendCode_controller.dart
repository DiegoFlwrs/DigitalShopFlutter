import 'package:digital_shop/features/auth/data/models/sendCode/sendCode_request.dart';
import 'package:digital_shop/features/auth/domain/useCases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendCodeController {
  final emailController = TextEditingController();
  final LoginUseCase loginUseCase;

  SendCodeController(this.loginUseCase);

  Future<void> sendCode(BuildContext context) async {
    final request = SendCodeRequest(
      email: emailController.text,
    );

    try {
      final response = await loginUseCase.executeSendCode(request);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("codigo enviadocorrectamente")),
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', emailController.text);

      Navigator.pushReplacementNamed(context, '/verifyCode');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
