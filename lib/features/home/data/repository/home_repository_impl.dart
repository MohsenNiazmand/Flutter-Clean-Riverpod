import 'package:flutter_clean_riverpod/features/home/data/services/home_api_service.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/home/domain/repository/home_repository.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(
    this._apiService,
  );

  final HomeApiService _apiService;

  @override
  Future<Either<ExceptionHandler, ApiResponse<dynamic>>>
      fetchHomeData() async {
    try {
      final result = await _apiService.fetchHomeData();
      if (result.status == ResultTypeEnum.success.value) {
        return Right(result);
      } else {
        final errorMessage = result.message;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    }
  }
}
