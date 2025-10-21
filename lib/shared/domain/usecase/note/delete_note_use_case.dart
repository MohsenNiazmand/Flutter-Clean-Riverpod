
import 'package:flutter_clean_riverpod/shared/domain/repository/note_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class DeleteNoteByIdUseCase implements UseCase<void, int> {
  DeleteNoteByIdUseCase(this._noteRepository);

  final NoteRepository _noteRepository;

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

  final NoteRepository _noteRepository;

  @override
  Future<void> call({
    void params,
  }) async {
    await _noteRepository.deleteAllNotes();
  }
}
