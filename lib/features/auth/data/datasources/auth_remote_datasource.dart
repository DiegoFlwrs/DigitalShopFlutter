import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_request.dart';
import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_response.dart';
import 'package:digital_shop/features/auth/data/models/registrer/registrer_request.dart';
import 'package:digital_shop/features/auth/data/models/registrer/registrer_response.dart';
import 'package:digital_shop/features/auth/data/models/resetPassword/resetPassword_request.dart';
import 'package:digital_shop/features/auth/data/models/resetPassword/resetPassword_response.dart';
import 'package:digital_shop/features/auth/data/models/sendCode/sendCode_request.dart';
import 'package:digital_shop/features/auth/data/models/sendCode/sendCode_response.dart';
import 'package:digital_shop/features/auth/data/models/verifyCode/verifyCode_request.dart';
import 'package:digital_shop/features/auth/data/models/verifyCode/verifyCode_response.dart';

import '../../../../core/services/api_service.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRemoteDatasource {
  final ApiService _apiService;

  AuthRemoteDatasource(this._apiService);

  Future<LoginResponse> login(LoginRequest request) async {
    final json = await _apiService.post('/auth/login', request.toJson());
    return LoginResponse.fromJson(json);
  }

  Future<RegisterResponse> registrer(RegisterRequest request) async {
    final json = await _apiService.post('/users', request.toJson());
    return RegisterResponse.fromJson(json);
  }

  Future<SendCodeResponse> sendCode(SendCodeRequest request) async {
    final json = await _apiService.post('/auth/send-code', request.toJson());
    return SendCodeResponse.fromJson(json);
  }

  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest request) async {
    final json = await _apiService.post('/auth/verify-code', request.toJson());
    return VerifyCodeResponse.fromJson(json);
  }

  Future<ResetPasswordResponse> resetPasword(ResetPasswordRequest request) async {
    final json = await _apiService.post('/auth/reset-password', request.toJson());
    return ResetPasswordResponse.fromJson(json);
  }

  Future<List<GetProductResponse>> getProducts(GetProductRequest request) async {
  final jsonList = await _apiService.post('/gemini/busqueda', request.toJson());
  return (jsonList as List)
      .map((json) => GetProductResponse.fromJson(json))
      .toList();
}

}
