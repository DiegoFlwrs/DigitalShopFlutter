import 'package:digital_shop/features/auth/data/models/registrer/registrer_request.dart';
import 'package:digital_shop/features/auth/data/models/registrer/registrer_response.dart';

import '../../../../core/services/api_service.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRemoteDatasource {
  final ApiService _apiService;

  AuthRemoteDatasource(this._apiService);

  Future<LoginResponse> login(LoginRequest request) async {
    final json = await _apiService.post('/auth/login', request.toJson());
    print(json);
    return LoginResponse.fromJson(json);
  }

  Future<RegisterResponse> registrer(RegisterRequest request) async {
    final json = await _apiService.post('/users', request.toJson());
    print(json);
    return RegisterResponse.fromJson(json);
  }

}
