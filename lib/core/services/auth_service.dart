// auth_service.dart
import 'package:digital_shop/core/services/api_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiService _apiService;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    // clientId: '598756613803-gv0341e2fjv82r89jd8bjqkhok3mtmph.apps.googleusercontent.com',
    serverClientId:
        '598756613803-anblrr39dne4ntj5kud1pmjqoq6fj48v.apps.googleusercontent.com',
    // signInOption: SignInOption.standard,
  );

  AuthService(this._apiService);

  Future<void> loginWithGoogle() async {
    try {
      // Verificar si hay conexión a internet
      // Puedes agregar un paquete como connectivity_plus para esto
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('El usuario canceló el inicio de sesión');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // print("ID TOKEN: ${googleAuth.idToken}");
      // print("ACCESS TOKEN: ${googleAuth.accessToken}");

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
      print("Error Google Sign-In: $e");
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
