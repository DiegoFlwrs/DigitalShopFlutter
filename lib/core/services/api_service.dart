import 'dart:convert';
import 'package:http/http.dart' as http;
// import '../constants/api_config.dart';

class ApiService {
  final client = http.Client();

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    String baseUrl = "http://10.0.2.2:3000";
    final response = await client.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }

  // Puedes agregar métodos GET, PUT, DELETE aquí también.
}
