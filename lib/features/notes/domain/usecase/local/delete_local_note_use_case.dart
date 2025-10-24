
import 'package:flutter_clean_riverpod/features/notes/domain/repository/note_local_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class DeleteLocalNoteByIdUseCase implements UseCase<void, int> {
  DeleteLocalNoteByIdUseCase(this._noteRepository);

  final NoteLocalRepository _noteRepository;

  @override
  Future<void> call({
    int? params,
  }) async {
    if (params != null) {
      await _noteRepository.deleteNoteById(params);
    }
  }
}

class DeleteAllNotesUseCase implements UseCase<void, void> {
  DeleteAllNotesUseCase(this._noteRepository);

  final NoteLocalRepository _noteRepository;

  @override
  Future<void> call({
    void params,
  }) async {
    await _noteRepository.deleteAllNotes();
  }
}
