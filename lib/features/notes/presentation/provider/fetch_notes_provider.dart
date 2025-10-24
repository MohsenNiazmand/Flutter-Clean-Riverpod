import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/notes/data/model/all_notes_model.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/delete_local_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/insert_all_local_notes_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/remote/fetch_notes_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/provider/notes_state_manager.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_notes_provider.g.dart';

/// Legacy provider - use notesStateProvider instead
@Deprecated('Use notesStateProvider instead')
final notesDataProvider = StateProvider<List<NoteModel>>((ref) => []);

@Riverpod(keepAlive: true)
class FetchNotesProvider extends _$FetchNotesProvider {
  @override
  DataState<HttpResponse<AllNotesModel>> build() {
    return const DataInitial();
  }

  Future<void> fetchNotes() async {
    try {
      // 1. Get current state from state manager
      final stateManager = ref.read(notesStateProvider.notifier);
      final currentNotes = ref.read(notesStateProvider);
      
      // 2. Set loading state only if no local data
      if (currentNotes.isEmpty) {
        state = const DataLoading();
      }
      
      // 3. Fetch from API (background sync)
      final response = await getIt<FetchNotesUseCase>().call();
      await response.fold((l) {
        // If API fails but we have local data, keep local data
        if (currentNotes.isEmpty) {
          state = DataFailed(l);
        }
        // If we have local data, don't change state (keep local data)
      }, (r) async {
        // 4. Update local storage with fresh data from API
        if (r.data.results?.isNotEmpty ?? false) {
          // Clear local storage first to avoid duplicates
          await getIt<DeleteAllNotesUseCase>().call();
          // Insert fresh data
          await getIt<InsertAllLocalNotesUseCase>().call(
            params: r.data.results ?? [],
          );
          // 5. Update state manager with fresh data
          stateManager.replaceAllNotes(r.data.results ?? []);
        }
        state = DataSuccess(r);
      });
    } catch (e) {
      // Handle unexpected errors
      state = DataFailed(ExceptionHandler(messageException: e.toString()));
    }
  }

  /// Refresh notes from local storage
  Future<void> refreshFromLocal() async {
    final stateManager = ref.read(notesStateProvider.notifier);
    await stateManager.refreshFromLocal();
  }
}
