
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:dartz/dartz.dart';


abstract class HomeRepository {
  Future<Either<ExceptionHandler, ApiResponse<dynamic>>> fetchHomeData();
}