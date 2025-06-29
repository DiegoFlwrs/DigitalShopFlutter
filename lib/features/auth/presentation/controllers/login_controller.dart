import 'package:digital_shop/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/login_request.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  Future<void> login(BuildContext context) async {
    final request = LoginRequest(
      email: emailController.text,
      password: passwordController.text,
    );

    try {
      final response = await loginUseCase.execute(request);
      print('Token: ${response}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login exitoso")),
      );
      print('--------------------Login exitoso: ${response}');
      final prefs = await SharedPreferences.getInstance();
      // // print("id: ${response.userId.toString()}");
      // await prefs.setInt('userId', response.userId);
      await prefs.setInt('userId', 3);
      Navigator.pushReplacementNamed(context, '/search');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
