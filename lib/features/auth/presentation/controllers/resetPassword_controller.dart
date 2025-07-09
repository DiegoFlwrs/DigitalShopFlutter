import 'package:digital_shop/features/auth/data/models/resetPassword/ResetPasswordRequestNoCode.dart';
import 'package:digital_shop/features/auth/data/models/resetPassword/resetPassword_request.dart';
import 'package:digital_shop/features/auth/domain/useCases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final LoginUseCase loginUseCase;

  ResetPasswordController(this.loginUseCase);

  Future<void> resetPassword(BuildContext context) async {

    if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Las contraseñas no coinciden")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final emailEnviar = prefs.getString('user_email');
    final codeEnviar = prefs.getString('user_code');
    final request = ResetPasswordRequest(
      email: emailEnviar.toString(),
      code: codeEnviar.toString(),
      newPassword: newPasswordController.text,
    );

    final requestNoCode = ResetPasswordNoCodeRequest(
      email: emailEnviar.toString(),
      newPassword: newPasswordController.text,
    );
    final response;
    try {
      if(codeEnviar == null){
        print("requestNoCode");
        response = await loginUseCase.executeResetPasswordNoCode(requestNoCode);
        // response = await loginUseCase.executeResetPassword(request);
      }else{
        print("request");
        response = await loginUseCase.executeResetPassword(request);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: response),
        // SnackBar(content: Text("Contraseña Actualizada!")),
      );

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
