import 'package:digital_shop/features/auth/data/models/registrer/registrer_request.dart';
import 'package:digital_shop/features/auth/data/models/registrer/registrer_response.dart';
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

}
