import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_request.dart';
import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_response.dart';
import 'package:digital_shop/features/auth/data/models/registrer/registrer_request.dart';
import 'package:digital_shop/features/auth/data/models/registrer/registrer_response.dart';
import 'package:digital_shop/features/auth/data/models/resetPassword/ResetPasswordRequestNoCode.dart';
import 'package:digital_shop/features/auth/data/models/resetPassword/resetPassword_request.dart';
import 'package:digital_shop/features/auth/data/models/resetPassword/resetPassword_response.dart';
import 'package:digital_shop/features/auth/data/models/sendCode/sendCode_request.dart';
import 'package:digital_shop/features/auth/data/models/sendCode/sendCode_response.dart';
import 'package:digital_shop/features/auth/data/models/verifyCode/verifyCode_request.dart';
import 'package:digital_shop/features/auth/data/models/verifyCode/verifyCode_response.dart';
import 'package:digital_shop/features/auth/domain/repositories/implement/auth_repository.dart';

import '../../data/models/login_request.dart';
import '../../data/models/login_response.dart';

class LoginUseCase {
  final AuthRepositoryImpl repository;

  LoginUseCase(this.repository);

  Future<LoginResponse> execute(LoginRequest request) async {
    return await repository.login(request);
  }
  
  Future<RegisterResponse> executeRegister(RegisterRequest request) async {
    return await repository.registrer(request);
  }

  Future<SendCodeResponse> executeSendCode(SendCodeRequest request) async {
    return await repository.sendCode(request);
  }

  Future<VerifyCodeResponse> executeVerifyCode(VerifyCodeRequest request) async {
    return await repository.verifyCode(request);
  }

  Future<ResetPasswordResponse> executeResetPassword(ResetPasswordRequest request) async {
    return await repository.resetPassword(request);
  }

  Future<ResetPasswordResponse> executeResetPasswordNoCode(ResetPasswordNoCodeRequest request) async {
    return await repository.resetPaswordNoCode(request);
  }

  Future<List<GetProductResponse>> executeGetProducts(GetProductRequest request) async {
    return await repository.getProducts(request);
  }

}
