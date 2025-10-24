import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/repository/notes_remote_repository.dart';
import 'package:retrofit/dio.dart';

class DeleteNoteUseCase {
  DeleteNoteUseCase(this.repository);
  final NotesRepository repository;

  Future<Either<ExceptionHandler, HttpResponse<dynamic>>> call(int id) {
    return repository.deleteNote(id);
  }
}
