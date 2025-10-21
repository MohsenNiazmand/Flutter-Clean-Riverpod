
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';


abstract class HomeRepository {
  Future<Either<ExceptionHandler, ApiResponse<List<NoteModel>>>> fetchHomeData();
}