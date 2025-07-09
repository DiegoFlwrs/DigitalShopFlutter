import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import '../constants/api_config.dart';

class ApiService {
  final client = http.Client();

  Future<Map<String, String>> _getAuthHeaders() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('tokenAccess');
  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
  
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    // String baseUrl = "http://192.168.1.9:3000";
    String baseUrl = "http://10.0.2.2:3000";
    // String baseUrl = "http://localhost:3000";
    final headers = await _getAuthHeaders();
    final response = await client.post(
      Uri.parse('$baseUrl$endpoint'),
      // headers: {'Content-Type': 'application/json'},
      headers: headers,
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }


  Future<dynamic> get(String endpoint, {Map<String, String>? queryParams}) async {
  // String baseUrl = "http://192.168.1.9:3000";
  // String baseUrl = "http://localhost:3000";
  String baseUrl = "http://10.0.2.2:3000";
  final headers = await _getAuthHeaders();
  Uri uri = Uri.parse('$baseUrl$endpoint');
  if (queryParams != null && queryParams.isNotEmpty) {
    uri = uri.replace(queryParameters: queryParams);
  }

  final response = await client.get(
    uri,
    headers: headers,
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error: ${response.statusCode}');
  }
}

Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
  // String baseUrl = "http://localhost:3000";
  // String baseUrl = "http://192.168.1.9:3000";
  String baseUrl = "http://10.0.2.2:3000";
  final headers = await _getAuthHeaders();
  final response = await client.put(
    Uri.parse('$baseUrl$endpoint'),
    headers: headers,
    body: json.encode(data),
  );
  if (response.statusCode == 200 || response.statusCode == 204) {
    return response.body.isNotEmpty ? json.decode(response.body) : null;
  } else {
    throw Exception('Error: ${response.statusCode}');
  }
}


Future<dynamic> delete(String endpoint, {Map<String, String>? queryParams}) async {
  // String baseUrl = "http://localhost:3000";
  // String baseUrl = "http://192.168.1.9:3000";
  String baseUrl = "http://10.0.2.2:3000";
  final headers = await _getAuthHeaders();
  Uri uri = Uri.parse('$baseUrl$endpoint');
  if (queryParams != null && queryParams.isNotEmpty) {
    uri = uri.replace(queryParameters: queryParams);
  }

  final response = await client.delete(
    uri,
    headers: headers,
  );

  if (response.statusCode == 200 || response.statusCode == 204) {
    return response.body.isNotEmpty ? json.decode(response.body) : null;
  } else {
    throw Exception('Error: ${response.statusCode}');
  }
}

// Future<dynamic> postToken(String endpoint, Map<String, dynamic> data, String token) async {
//   String baseUrl = "http://192.168.1.9:3000";

//   final headers = {
//     'Content-Type': 'application/json',
//     'Authorization': token, // ya incluye "Bearer ..."
//   };

//   final response = await client.post(
//     Uri.parse('$baseUrl$endpoint'),
//     headers: headers,
//     body: json.encode(data),
//   );

//   if (response.statusCode == 200 || response.statusCode == 201) {
//     return json.decode(response.body);
//   } else {
//     throw Exception('Error: ${response.statusCode} - ${response.body}');
//   }
// }
  // Puedes agregar métodos GET, PUT, DELETE aquí también.
}
