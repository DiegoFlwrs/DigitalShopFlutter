import 'package:digital_shop/features/auth/data/models/registrer/registrer_request.dart';
import 'package:digital_shop/features/auth/data/models/registrer/registrer_response.dart';

import '../../../data/models/login_request.dart';
import '../../../data/models/login_response.dart';

abstract class iAuthRepository {
  Future<LoginResponse> login(LoginRequest request);

  Future<RegisterResponse> registrer(RegisterRequest request);
}