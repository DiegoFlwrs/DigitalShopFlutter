import 'package:digital_shop/features/auth/data/models/registrer/registrer_request.dart';
import 'package:digital_shop/features/auth/domain/useCases/login_usecase.dart';
import 'package:flutter/material.dart';

class RegistrerController {
  final nameController = TextEditingController();
  final apellidoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController(); // Agrega esto
  final LoginUseCase loginUseCase;

  RegistrerController(this.loginUseCase);

  Future<void> registrer(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Las contraseñas no coinciden")),
      );
      return;
    }

    final request = RegisterRequest(
      name: nameController.text + " " + apellidoController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    try {
      final response = await loginUseCase.executeRegister(request);
      print('Token: ${response}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario registrado exitosamente")),
      );

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
