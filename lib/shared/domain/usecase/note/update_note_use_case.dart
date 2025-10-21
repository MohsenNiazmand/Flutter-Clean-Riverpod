import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/repository/note_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class UpdateNoteUseCase implements UseCase<void, NoteModel> {
  UpdateNoteUseCase(this._noteRepository);

  final NoteRepository _noteRepository;

  @override
  Future<void> call({
    NoteModel? params,
  }) async {
    if (params != null) {
      await _noteRepository.updateNote(params);
    }
  }
}
