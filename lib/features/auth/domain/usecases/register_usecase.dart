import 'package:flutter_clean_riverpod/features/auth/data/models/auth_response.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class RegisterUseCase
    implements
        UseCase<Either<ExceptionHandler, ApiResponse<AuthResponse>>,
            Map<String, dynamic>> {
  RegisterUseCase(this._repo);

  final AuthRepository _repo;

  @override
  Future<Either<ExceptionHandler, ApiResponse<AuthResponse>>> call({
    Map<String, dynamic>? params,
  }) async {
    return _repo.register(
      firstName: params?['first_name'] as String,
      lastName: params?['last_name'] as String,
      email: params?['email'] as String,
      password: params?['password'] as String,
      passwordConfirmation: params?['password_confirmation'] as String,
      activationToken: params?['activation_token'] as String,
    );
  }
}
