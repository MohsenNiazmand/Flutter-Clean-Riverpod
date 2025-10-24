import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/notes/data/model/all_notes_model.dart';
import 'package:flutter_clean_riverpod/features/notes/data/services/notes_api_service.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/repository/notes_remote_repository.dart';
import 'package:flutter_clean_riverpod/shared/data/local/database_helper.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:retrofit/dio.dart';

class NotesRepositoryImpl implements NotesRepository {
  NotesRepositoryImpl(
    this._apiService,
    this._databaseHelper,
  );

  final NotesApiService _apiService;
  final DatabaseHelper _databaseHelper;

  @override
  Future<Either<ExceptionHandler, HttpResponse<AllNotesModel>>>
      fetchNotes() async {
    try {
      final result = await _apiService.fetchNotes();
      if (result.response.statusCode == 200) {
        if (result.data.results?.isNotEmpty ?? false) {
          await _databaseHelper.insertAllNotes(result.data.results ?? []);
        }
        return Right(result);
      } else {
        final errorMessage = result.response.data['detail'] as String;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    }
  }

  @override
  Future<Either<ExceptionHandler, HttpResponse<NoteModel>>> createNote(
      Map<String, dynamic> data) async {
    try {
      final result = await _apiService.createNote(data);
      if (result.response.statusCode == 201) {
        return Right(result);
      } else {
        final errorMessage = result.response.data['detail'] as String;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    }
  }

  @override
  Future<Either<ExceptionHandler, HttpResponse<NoteModel>>> updateNote(
      int id, Map<String, dynamic> data) async {
    try {
      final result = await _apiService.updateNote(id, data);
      if (result.response.statusCode == 200) {
        return Right(result);
      } else {
        final errorMessage = result.response.data['detail'] as String;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    }
  }

  @override
  Future<Either<ExceptionHandler, HttpResponse<dynamic>>> deleteNote(
      int id) async {
    try {
      final result = await _apiService.deleteNote(id);
      if (result.response.statusCode == 204) {
        return Right(result);
      } else {
        final errorMessage = result.response.data['detail'] as String;
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
