import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/get_local_note_use_case.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Central state manager for notes that syncs with local data
final notesStateProvider = StateNotifierProvider<NotesStateNotifier, List<NoteModel>>((ref) {
  return NotesStateNotifier();
});

class NotesStateNotifier extends StateNotifier<List<NoteModel>> {
  NotesStateNotifier() : super([]);


  /// Add a new note to the state (checks for duplicates)
  void addNote(NoteModel note) {
    // Check if note already exists
    if (note.id != null && state.any((existingNote) => existingNote.id == note.id)) {
      // Update existing note instead of adding duplicate
      updateNote(note);
      return;
    }
    state = [...state, note];
  }

  /// Update an existing note in the state
  void updateNote(NoteModel updatedNote) {
    state = state.map((NoteModel note) {
      if (note.id == updatedNote.id) {
        return updatedNote;
      }
      return note;
    }).toList();
  }

  /// Remove a note from the state
  void removeNote(int noteId) {
    state = state.where((NoteModel note) => note.id != noteId).toList();
  }

  /// Replace all notes with new data (removes duplicates)
  void replaceAllNotes(List<NoteModel> notes) {
    // Remove duplicates based on ID
    final uniqueNotes = <int, NoteModel>{};
    for (final note in notes) {
      if (note.id != null) {
        uniqueNotes[note.id!] = note;
      }
    }
    state = uniqueNotes.values.toList();
  }

  /// Get a specific note by ID
  NoteModel? getNoteById(int id) {
    try {
      return state.firstWhere((NoteModel note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Refresh data from local storage (removes duplicates)
  Future<void> refreshFromLocal() async {
    try {
      final localNotes = await getIt<GetLocalNotesUseCase>().call();
      // Remove duplicates based on ID
      final uniqueNotes = <int, NoteModel>{};
      for (final note in localNotes) {
        if (note.id != null) {
          uniqueNotes[note.id!] = note;
        }
      }
      state = uniqueNotes.values.toList();
    } catch (e) {
      // Handle error silently for now
      state = [];
    }
  }

  /// Clear all notes
  void clearNotes() {
    state = [];
  }
}

/// Provider for getting a specific note by ID
final noteByIdProvider = Provider.family<NoteModel?, int>((ref, id) {
  final notes = ref.watch(notesStateProvider);
  try {
    return notes.firstWhere((note) => note.id == id);
  } catch (e) {
    return null;
  }
});

/// Provider for filtered notes (e.g., by search term)
final filteredNotesProvider = Provider.family<List<NoteModel>, String?>((ref, searchTerm) {
  final notes = ref.watch(notesStateProvider);
  
  if (searchTerm == null || searchTerm.isEmpty) {
    return notes;
  }
  
  return notes.where((note) {
    final title = note.title?.toLowerCase() ?? '';
    final content = note.content?.toLowerCase() ?? '';
    final search = searchTerm.toLowerCase();
    
    return title.contains(search) || content.contains(search);
  }).toList();
});

/// Provider for notes count
final notesCountProvider = Provider<int>((ref) {
  final notes = ref.watch(notesStateProvider);
  return notes.length;
});

/// Provider for checking if notes are empty
final isNotesEmptyProvider = Provider<bool>((ref) {
  final notes = ref.watch(notesStateProvider);
  return notes.isEmpty;
});