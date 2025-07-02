// auth_provider.dart
import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/core/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> handleGoogleSignIn(BuildContext context) async {
    final authService = AuthService(ApiService());
    
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await authService.loginWithGoogle();
      
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      Navigator.pushReplacementNamed(context, '/search');
      
    } catch (e) {
      _errorMessage = _getUserFriendlyError(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!)),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _getUserFriendlyError(dynamic error) {
    if (error.toString().contains('sign_in_failed')) {
      return 'Error al conectar con Google. Verifica tu conexión.';
    } else if (error.toString().contains('network_error')) {
      return 'Problema de conexión. Verifica tu internet.';
    } else if (error.toString().contains('user cancelled')) {
      return 'Inicio de sesión cancelado';
    }
    return 'Error al iniciar sesión. Intenta nuevamente.';
  }
}