import 'package:flutter_clean_riverpod/features/notes/domain/repository/note_local_repository.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class InsertAllLocalNotesUseCase implements UseCase<void, List<NoteModel>> {
  InsertAllLocalNotesUseCase(this._noteRepository);

  final NoteLocalRepository _noteRepository;

  @override
  Future<void> call({
    List<NoteModel>? params,
  }) async {
    if (params != null) {
      await _noteRepository.insertAllNotes(params);
    }
  }
}
