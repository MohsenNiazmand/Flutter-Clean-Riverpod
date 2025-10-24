import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';

abstract class NoteLocalRepository {
  // Create new local with auto-generated ID
  Future<NoteModel> saveNote({
    required String title,
    required String body,
    NoteModel? noteModel,
  });

  // Get all notes
  Future<List<NoteModel>> getNotes();

  // Get specific local by ID
  Future<NoteModel?> getNoteById(int id);

  // Update existing local
  Future<void> updateNote(NoteModel noteModel);

  // Delete local by ID
  Future<void> deleteNoteById(int id);

  // Delete all notes
  Future<void> deleteAllNotes();

  // Insert notes from API
  Future<void> insertAllNotes(List<NoteModel> notes);
}
