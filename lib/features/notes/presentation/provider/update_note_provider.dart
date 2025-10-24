import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/update_local_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/remote/update_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/provider/notes_state_manager.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/provider/selected_note_provider.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:retrofit/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_note_provider.g.dart';

@riverpod
class UpdateNote extends _$UpdateNote {
  @override
  DataState<HttpResponse<NoteModel>> build() {
    return const DataInitial();
  }

  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
  }) async {
    try {
      // 1. Get original note for rollback
      final originalNote = ref.read(selectedNoteProvider);
      final stateManager = ref.read(notesStateProvider.notifier);
      
      // 2. Create updated note for optimistic update
      final updatedNote = originalNote?.copyWith(
        title: title,
        content: content,
        updatedAt: DateTime.now().toIso8601String(),
      );

      // 3. Update state manager immediately (optimistic update)
      if (updatedNote != null) {
        stateManager.updateNote(updatedNote);
      }

      state = const DataLoading();
      
      // 4. Save to local storage
      if (updatedNote != null) {
        await getIt<UpdateLocalNoteUseCase>().call(params: updatedNote);
      }

      // 5. API call
      final body = {
        'title': title,
        'content': content,
        'color': '#00FF00',
      };
      final response = await getIt<UpdateNoteUseCase>().call(id, body);
      
      await response.fold((l) async {
        // 6. Rollback on failure
        if (originalNote != null) {
          stateManager.updateNote(originalNote);
          await getIt<UpdateLocalNoteUseCase>().call(params: originalNote);
        }
        state = DataFailed(l);
      }, (r) async {
        // 7. Update with server data on success
        final serverNote = r.data;
        stateManager.updateNote(serverNote);
        await getIt<UpdateLocalNoteUseCase>().call(params: serverNote);
        state = DataSuccess(r);
      });
    } catch (e) {
      // Handle unexpected errors
      state = DataFailed(ExceptionHandler(messageException: e.toString()));
    }
  }
}
