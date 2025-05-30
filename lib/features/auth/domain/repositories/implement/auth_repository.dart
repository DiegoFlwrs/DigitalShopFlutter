// implementación concreta
import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_request.dart';
import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_response.dart';
import 'package:digital_shop/features/auth/data/models/login_request.dart';
import 'package:digital_shop/features/auth/data/models/login_response.dart';
import 'package:digital_shop/features/auth/data/models/registrer/registrer_request.dart';
import 'package:digital_shop/features/auth/data/models/registrer/registrer_response.dart';
import 'package:digital_shop/features/auth/data/models/resetPassword/resetPassword_request.dart';
import 'package:digital_shop/features/auth/data/models/resetPassword/resetPassword_response.dart';
import 'package:digital_shop/features/auth/data/models/sendCode/sendCode_request.dart';
import 'package:digital_shop/features/auth/data/models/sendCode/sendCode_response.dart';
import 'package:digital_shop/features/auth/data/models/verifyCode/verifyCode_request.dart';
import 'package:digital_shop/features/auth/data/models/verifyCode/verifyCode_response.dart';
import 'package:digital_shop/features/auth/domain/repositories/interface/iauth_repository.dart';

import '../../../data/datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements iAuthRepository {
  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<LoginResponse> login(LoginRequest request) {
    return datasource.login(request);
  }

  @override
  Future<RegisterResponse> registrer(RegisterRequest request) {
    return datasource.registrer(request);
  }

  @override
  Future<SendCodeResponse> sendCode(SendCodeRequest request) {
    return datasource.sendCode(request);
  }

  @override
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest request) {
    return datasource.verifyCode(request);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) {
    return datasource.resetPasword(request);
  }
  
  Future<List<GetProductResponse>> getProducts(GetProductRequest request) {
  return datasource.getProducts(request);
}
}
