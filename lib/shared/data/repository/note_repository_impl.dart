

import 'package:flutter_clean_riverpod/shared/data/local/database_helper.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {

  NoteRepositoryImpl(this._databaseHelper);
  final DatabaseHelper _databaseHelper;

  @override
  Future<void> saveNote({required String title, required String body}) async {
    await _databaseHelper.insertNote(title: title, body: body);
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    return await _databaseHelper.getNotes();
  }

  @override
  Future<NoteModel?> getNoteById(int id) async {
    return await _databaseHelper.getNoteById(id);
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
