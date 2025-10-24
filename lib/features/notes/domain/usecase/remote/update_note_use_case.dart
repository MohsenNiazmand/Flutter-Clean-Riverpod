import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/repository/notes_remote_repository.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:retrofit/dio.dart';

class UpdateNoteUseCase {
  UpdateNoteUseCase(this.repository);

  final NotesRepository repository;

  Future<Either<ExceptionHandler, HttpResponse<NoteModel>>> call(
    int id,
    Map<String, dynamic> data,
  ) {
    return repository.updateNote(id, data);
  }
}
