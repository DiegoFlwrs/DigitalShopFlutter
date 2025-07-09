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

import '../../../data/models/login_request.dart';
import '../../../data/models/login_response.dart';

abstract class iAuthRepository {
  Future<LoginResponse> login(LoginRequest request);

  Future<RegisterResponse> registrer(RegisterRequest request);

  Future<SendCodeResponse> sendCode(SendCodeRequest request);
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest request);
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request);
  Future<ResetPasswordResponse> resetPaswordNoCode(ResetPasswordNoCodeRequest request);
  Future<List<GetProductResponse>> getProducts(GetProductRequest request);
}