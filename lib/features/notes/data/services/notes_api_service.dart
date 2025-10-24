import 'package:dio/dio.dart';
import 'package:flutter_clean_riverpod/core/constants/constants.dart';
import 'package:flutter_clean_riverpod/features/notes/data/model/all_notes_model.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:retrofit/retrofit.dart';

part 'notes_api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class NotesApiService {
  factory NotesApiService(Dio dio) = _NotesApiService;

  @GET('notes/')
  Future<HttpResponse<AllNotesModel>> fetchNotes();

  @POST('notes/')
  Future<HttpResponse<NoteModel>> createNote(
    @Body() Map<String, dynamic> data,
  );

  @PATCH('notes/{id}/')
  Future<HttpResponse<NoteModel>> updateNote(
    @Path('id') int id,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('notes/{id}/')
  Future<HttpResponse<dynamic>> deleteNote(
    @Path('id') int id,
  );
}
