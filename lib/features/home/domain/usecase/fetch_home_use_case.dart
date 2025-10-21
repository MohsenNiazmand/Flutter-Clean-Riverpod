
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/home/domain/repository/home_repository.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:dartz/dartz.dart';

class FetchHomeUseCase {

  FetchHomeUseCase(this.repository);
  final HomeRepository repository;

  Future<Either<ExceptionHandler, ApiResponse<dynamic>>> call() {
    return repository.fetchHomeData();
  }
}
