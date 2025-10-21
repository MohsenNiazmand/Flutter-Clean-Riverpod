import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/note/delete_note_use_case.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/note/get_note_use_case.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/note/insert_all_notes_use_case.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/note/save_note_use_case.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/note/update_note_use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_provider.g.dart';

final selectedNoteProvider = StateProvider<NoteModel?>((ref) => null);

@Riverpod(keepAlive: true)
class Notes extends _$Notes {
  List<NoteModel> notes = [];

  @override
  List<NoteModel> build() {
    loadNotes();
    return notes;
  }

  // Create new note with title and body
  Future<void> saveNote({required String title, required String body}) async {
    await getIt<SaveNoteUseCase>().call(
      params: SaveNoteParams(title: title, body: body),
    );
    await loadNotes(); // Reload all notes
  }

  // Load all notes
  Future<void> loadNotes() async {
    notes = await getIt<GetNotesUseCase>().call();
    state = notes;
  }

  // Get specific note by ID
  Future<NoteModel?> getNoteById(int id) async {
    return await getIt<GetNoteByIdUseCase>().call(params: id);
  }

  // Update existing note
  Future<void> updateNote(NoteModel noteModel) async {
    await getIt<UpdateNoteUseCase>().call(params: noteModel);
    await loadNotes(); // Reload all notes
  }

  // Delete note by ID
  Future<void> deleteNoteById(int id) async {
    await getIt<DeleteNoteByIdUseCase>().call(params: id);
    await loadNotes(); // Reload all notes
  }

  // Delete all notes
  Future<void> deleteAllNotes() async {
    await getIt<DeleteAllNotesUseCase>().call();
    notes = [];
    state = notes;
  }

  // Insert notes from API
  Future<void> insertAllNotes(List<NoteModel> apiNotes) async {
    await getIt<InsertAllNotesUseCase>().call(params: apiNotes);
    await loadNotes(); // Reload all notes
  }
}
