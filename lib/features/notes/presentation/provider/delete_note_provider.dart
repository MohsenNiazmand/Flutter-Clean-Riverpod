import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/repository/note_local_repository.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/create_local_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/delete_local_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/remote/delete_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/provider/notes_state_manager.dart';
import 'package:retrofit/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_note_provider.g.dart';

@riverpod
class DeleteNote extends _$DeleteNote {
  @override
  DataState<HttpResponse<dynamic>> build() {
    return const DataInitial();
  }

  Future<void> deleteNote(int id) async {
    try {
      // 1. Get note for rollback
      final note = await getIt<NoteLocalRepository>().getNoteById(id);
      final stateManager = ref.read(notesStateProvider.notifier)
      
      // 2. Remove from state manager immediately (optimistic update)
      ..removeNote(id);
      
      // 3. Delete from local storage
      await getIt<DeleteLocalNoteByIdUseCase>().call(params: id);
      
      state = const DataLoading();
      
      // 4. API call
      final response = await getIt<DeleteNoteUseCase>().call(id);
      
      await response.fold((l) async {
        // 5. Rollback on failure
        if (note != null) {
          stateManager.addNote(note);
          await getIt<CreateLocalNoteUseCase>().call(
            params: CreateNoteParams(
              title: note.title ?? '',
              body: note.content ?? '',
              noteModel: note,
            ),
          );
        }
        state = DataFailed(l);
      }, (r) {
        // 6. Success - note is already removed
        state = DataSuccess(r);
      });
    } catch (e) {
      // Handle unexpected errors
      state = DataFailed(ExceptionHandler(messageException: e.toString()));
    }
  }
}
