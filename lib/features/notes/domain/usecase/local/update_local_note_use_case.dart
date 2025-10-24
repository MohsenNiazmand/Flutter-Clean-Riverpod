import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/repository/note_local_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class UpdateLocalNoteUseCase implements UseCase<void, NoteModel> {
  UpdateLocalNoteUseCase(this._noteRepository);

  final NoteLocalRepository _noteRepository;

  @override
  Future<void> call({
    NoteModel? params,
  }) async {
    if (params != null) {
      await _noteRepository.updateNote(params);
    }
  }
}
