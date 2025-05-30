// implementación concreta
import 'package:digital_shop/features/auth/data/models/login_request.dart';
import 'package:digital_shop/features/auth/data/models/login_response.dart';
import 'package:digital_shop/features/auth/data/models/registrer/registrer_request.dart';
import 'package:digital_shop/features/auth/data/models/registrer/registrer_response.dart';
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
  
}
