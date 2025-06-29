// auth_service.dart
import 'package:digital_shop/core/services/api_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiService _apiService;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    signInOption: SignInOption.standard,
  );

  AuthService(this._apiService);

  Future<void> loginWithGoogle() async {
    try {
      // Verificar si hay conexión a internet
      // Puedes agregar un paquete como connectivity_plus para esto
      print("3");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print("3 v2");
      
      if (googleUser == null) {
        throw Exception('El usuario canceló el inicio de sesión');
      }

      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      if (googleAuth.idToken == null) {
        throw Exception('No se pudo obtener el token de Google');
      }

      // Enviar datos al backend
      final response = await _apiService.post('/auth/google', {
        'token': googleAuth.idToken,
        'accessToken': googleAuth.accessToken,
        'email': googleUser.email,
        'name': googleUser.displayName,
      });

      if (response['token'] == null) {
        throw Exception('No se recibió token del servidor');
      }

      await _saveUserData(response);
    } catch (e) {
      // Cerrar sesión de Google si hay error
      await _googleSignIn.signOut();
      rethrow;
    }
  }

  Future<void> _saveUserData(Map<String, dynamic> response) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response['token']);
      await prefs.setInt('userId', response['user']['id']);
      await prefs.setString('userEmail', response['user']['email']);
      await prefs.setString('userName', response['user']['name']);
    } catch (e) {
      throw Exception('Error al guardar datos de usuario: $e');
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }
}