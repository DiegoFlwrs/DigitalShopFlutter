import 'package:digital_shop/features/auth/data/models/verifyCode/verifyCode_request.dart';
import 'package:digital_shop/features/auth/domain/useCases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyCodeController {
  final codeController = TextEditingController();
  final LoginUseCase loginUseCase;

  VerifyCodeController(this.loginUseCase);

  Future<void> verifyCode(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final emailEnviar = prefs.getString('user_email');
    final request = VerifyCodeRequest(
      email: emailEnviar.toString(),
      code: codeController.text,
    );

    try {
      final response = await loginUseCase.executeVerifyCode(request);
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("codigo verificado")),
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_code', codeController.text);
      Navigator.pushReplacementNamed(context, '/newPassword');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
