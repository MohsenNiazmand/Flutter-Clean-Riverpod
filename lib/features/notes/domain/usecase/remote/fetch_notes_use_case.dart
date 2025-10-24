
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/notes/data/model/all_notes_model.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/repository/notes_remote_repository.dart';
import 'package:retrofit/dio.dart';

class FetchNotesUseCase {

  FetchNotesUseCase(this.repository);
  final NotesRepository repository;

  Future<Either<ExceptionHandler, HttpResponse<AllNotesModel>>> call() {
    return repository.fetchNotes();
  }
}
