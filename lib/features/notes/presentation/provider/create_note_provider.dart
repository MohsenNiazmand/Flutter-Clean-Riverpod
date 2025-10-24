import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/create_local_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/delete_local_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/remote/create_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/provider/notes_state_manager.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:retrofit/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_note_provider.g.dart';

@riverpod
class CreateNote extends _$CreateNote {
  @override
  DataState<HttpResponse<NoteModel>> build() {
    return const DataInitial();
  }

  Future<void> createNote({
    String? title,
    String? content,
  }) async {
    try {
      // 1. Create optimistic note for immediate UI update
      final optimisticNote = NoteModel(
        id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
        title: title,
        content: content,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );

      // 2. Add to state manager immediately (optimistic update)
      final stateManager = ref.read(notesStateProvider.notifier)
      ..addNote(optimisticNote);

      state = const DataLoading();
      
      // 3. Save to local storage
      await getIt<CreateLocalNoteUseCase>().call(
        params: CreateNoteParams(
          title: title ?? '',
          body: content ?? '',
          noteModel: optimisticNote,
        ),
      );

      // 4. API call
      final body = {'title': title, 'content': content, 'color': '#FF5733'};
      final response = await getIt<CreateNoteUseCase>().call(body);
      
      await response.fold((l) async {
        // 5. Rollback on failure
        stateManager.removeNote(optimisticNote.id!);
        await getIt<DeleteLocalNoteByIdUseCase>().call(
          params: optimisticNote.id!,
        );
        state = DataFailed(l);
      }, (r) async {
        // 6. Update with server data on success
        final serverNote = r.data;
        stateManager.updateNote(serverNote);
        await getIt<CreateLocalNoteUseCase>().call(
          params: CreateNoteParams(
            title: serverNote.title ?? '',
            body: serverNote.content ?? '',
            noteModel: serverNote,
          ),
        );
        state = DataSuccess(r);
      });
    } catch (e) {
      // Handle unexpected errors
      state = DataFailed(ExceptionHandler(messageException: e.toString()));
    }
  }
}
