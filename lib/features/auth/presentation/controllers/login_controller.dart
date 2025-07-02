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
      
      // Guardar datos de sesión
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('tokenAccess', response.token);
      await prefs.setInt('userId', response.userId);
      await prefs.setString('userEmail', emailController.text);
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('loginTimestamp', DateTime.now().toString());

      // Limpiar campos
      emailController.clear();
      passwordController.clear();

      // Navegar a pantalla principal
      Navigator.pushNamedAndRemoveUntil(
        context, 
        '/search', 
        (route) => false
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Método para verificar sesión existente
  static Future<bool> checkActiveSession() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final token = prefs.getString('tokenAccess');
    
    // Verificar que tenga token y esté marcado como logueado
    return isLoggedIn && token != null && token.isNotEmpty;
  }

  // Método para obtener el token almacenado
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('tokenAccess');
  }

  // Método para obtener el ID de usuario
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  // Método para cerrar sesión
  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Limpiar todos los datos
    
    // Navegar a pantalla de login
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/welcome',
      (route) => false,
    );
  }
}