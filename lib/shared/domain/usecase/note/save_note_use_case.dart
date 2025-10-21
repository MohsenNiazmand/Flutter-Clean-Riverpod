

import 'package:flutter_clean_riverpod/shared/domain/repository/note_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class SaveNoteUseCase implements UseCase<void, SaveNoteParams> {
  SaveNoteUseCase(this._noteRepository);

  final NoteRepository _noteRepository;

  @override
  Future<void> call({
    SaveNoteParams? params,
  }) async {
    if (params != null) {
      await _noteRepository.saveNote(
        title: params.title,
        body: params.body,
      );
    }
  }
}

class SaveNoteParams {
  SaveNoteParams({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}
