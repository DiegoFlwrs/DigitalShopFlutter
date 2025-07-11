import 'package:shared_preferences/shared_preferences.dart';

class SessionHelper {
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  static Future<void> setUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  // Puedes agregar otros métodos para manejar token, usuario, etc.
}
