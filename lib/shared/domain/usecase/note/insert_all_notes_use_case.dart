import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/repository/note_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class InsertAllNotesUseCase implements UseCase<void, List<NoteModel>> {
  InsertAllNotesUseCase(this._noteRepository);

  final NoteRepository _noteRepository;

  @override
  Future<void> call({
    List<NoteModel>? params,
  }) async {
    if (params != null) {
      await _noteRepository.insertAllNotes(params);
    }
  }
}
