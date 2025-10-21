import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/activation_code_response.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class SendActivationTokenUseCase
    implements
        UseCase<Either<ExceptionHandler, ApiResponse<ActivationTokenResponse>>,
            String> {
  SendActivationTokenUseCase(this._repo);

  final AuthRepository _repo;

  @override
  Future<Either<ExceptionHandler, ApiResponse<ActivationTokenResponse>>> call({
    String? params,
  }) {
    return _repo.sendActivationToken(email: params ?? '');
  }
}
