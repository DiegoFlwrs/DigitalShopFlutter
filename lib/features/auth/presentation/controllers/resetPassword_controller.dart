import 'package:digital_shop/features/auth/data/models/resetPassword/ResetPasswordRequestNoCode.dart';
import 'package:digital_shop/features/auth/data/models/resetPassword/resetPassword_request.dart';
import 'package:digital_shop/features/auth/data/models/resetPassword/resetPassword_response.dart';
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
    final emailEnviar2 = prefs.getString('userEmail');

    try {
      late final ResetPasswordResponse
          response; // Cambia aquí el tipo al correcto

      if (codeEnviar == null) {
        if (emailEnviar2 == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("No se encontró el email del usuario")),
          );
          return;
        }
        final requestNoCode = ResetPasswordNoCodeRequest(
          email: emailEnviar2.toString(),
          newPassword: newPasswordController.text,
        );
        response = await loginUseCase.executeResetPasswordNoCode(requestNoCode);
      } else {
        if (emailEnviar == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("No se encontró el email del usuario")),
          );
          return;
        }
        print("request");
        final request = ResetPasswordRequest(
          email: emailEnviar,
          code: codeEnviar,
          newPassword: newPasswordController.text,
        );
        response = await loginUseCase.executeResetPassword(request);
      }

      // Extrae un mensaje para mostrar (ajusta el nombre del campo según tu modelo)
      String mensajeParaMostrar = response.message ?? "Contraseña Actualizada!";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensajeParaMostrar)),
      );

      await Future.delayed(const Duration(seconds: 2));

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
