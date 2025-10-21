
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/repository/note_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class GetNotesUseCase implements UseCase<List<NoteModel>, void> {
  GetNotesUseCase(this._noteRepository);

  final NoteRepository _noteRepository;

  @override
  Future<List<NoteModel>> call({
    void params,
  }) async {
    return await _noteRepository.getNotes();
  }
}

class GetNoteByIdUseCase implements UseCase<NoteModel?, int> {
  GetNoteByIdUseCase(this._noteRepository);

  final NoteRepository _noteRepository;

  @override
  Future<NoteModel?> call({
    int? params,
  }) async {
    if (params != null) {
      return await _noteRepository.getNoteById(params);
    }
    return null;
  }
}
