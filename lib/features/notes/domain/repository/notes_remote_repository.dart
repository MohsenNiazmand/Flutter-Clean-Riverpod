import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/notes/data/model/all_notes_model.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:retrofit/dio.dart';

abstract class NotesRepository {
  Future<Either<ExceptionHandler, HttpResponse<AllNotesModel>>> fetchNotes();

  Future<Either<ExceptionHandler, HttpResponse<NoteModel>>> createNote(
    Map<String, dynamic> data,
  );

  Future<Either<ExceptionHandler, HttpResponse<NoteModel>>> updateNote(
    int id,
    Map<String, dynamic> data,
  );

  Future<Either<ExceptionHandler, HttpResponse<dynamic>>> deleteNote(int id);
}
