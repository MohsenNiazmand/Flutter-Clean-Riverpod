
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/home/domain/repository/home_repository.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';

class FetchHomeUseCase {

  FetchHomeUseCase(this.repository);
  final HomeRepository repository;

  Future<Either<ExceptionHandler, ApiResponse<List<NoteModel>>>> call() {
    return repository.fetchHomeData();
  }
}
