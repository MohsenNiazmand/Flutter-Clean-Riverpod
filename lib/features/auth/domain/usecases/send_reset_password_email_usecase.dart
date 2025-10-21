import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class SendResetPasswordEmailUseCase
    implements
        UseCase<Either<ExceptionHandler, ApiResponse<dynamic>>, String> {
  SendResetPasswordEmailUseCase(this._repo);

  final AuthRepository _repo;

  @override
  Future<Either<ExceptionHandler, ApiResponse<dynamic>>> call({
    String? params,
  }) async {
    return _repo.sendResetPasswordEmail(email: params ?? '');
  }
}
