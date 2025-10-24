import 'package:flutter_clean_riverpod/shared/data/local/database_helper.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/repository/note_local_repository.dart';

class NoteLocalRepositoryImpl extends NoteLocalRepository {
  NoteLocalRepositoryImpl(this._databaseHelper);

  final DatabaseHelper _databaseHelper;

  @override
  Future<NoteModel> saveNote({
    required String title,
    required String body,
    NoteModel? noteModel,
  }) async {
    return _databaseHelper.insertNote(
      title: title,
      body: body,
      noteModel: noteModel,
    );
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    return _databaseHelper.getNotes();
  }

  @override
  Future<NoteModel?> getNoteById(int id) async {
    return _databaseHelper.getNoteById(id);
  }

  @override
  Future<void> updateNote(NoteModel noteModel) async {
    await _databaseHelper.updateNote(noteModel);
  }

  @override
  Future<void> deleteNoteById(int id) async {
    await _databaseHelper.deleteNoteById(id);
  }

  @override
  Future<void> deleteAllNotes() async {
    await _databaseHelper.deleteAllNotes();
  }

  @override
  Future<void> insertAllNotes(List<NoteModel> notes) async {
    await _databaseHelper.insertAllNotes(notes);
  }
}
