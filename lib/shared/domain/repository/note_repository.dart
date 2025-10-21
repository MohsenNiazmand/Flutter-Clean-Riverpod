
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';

abstract class NoteRepository {
  // Create new note with auto-generated ID
  Future<void> saveNote({required String title, required String body});
  
  // Get all notes
  Future<List<NoteModel>> getNotes();
  
  // Get specific note by ID
  Future<NoteModel?> getNoteById(int id);
  
  // Update existing note
  Future<void> updateNote(NoteModel noteModel);
  
  // Delete note by ID
  Future<void> deleteNoteById(int id);
  
  // Delete all notes
  Future<void> deleteAllNotes();
  
  // Insert notes from API
  Future<void> insertAllNotes(List<NoteModel> notes);
}
