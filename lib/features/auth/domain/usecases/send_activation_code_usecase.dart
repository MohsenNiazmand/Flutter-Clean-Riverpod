import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/activation_code_response.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';
import 'package:retrofit/dio.dart';

class SendActivationTokenUseCase
    implements
        UseCase<Either<ExceptionHandler, HttpResponse<ActivationTokenResponse>>,
            String> {
  SendActivationTokenUseCase(this._repo);

  final AuthRepository _repo;

  @override
  Future<Either<ExceptionHandler, HttpResponse<ActivationTokenResponse>>> call({
    String? params,
  }) {
    return _repo.sendActivationToken(email: params ?? '');
  }
}
