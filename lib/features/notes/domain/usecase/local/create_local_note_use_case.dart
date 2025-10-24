import 'package:flutter_clean_riverpod/features/notes/domain/repository/note_local_repository.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class CreateLocalNoteUseCase implements UseCase<void, CreateNoteParams> {
  CreateLocalNoteUseCase(this._noteRepository);

  final NoteLocalRepository _noteRepository;

  @override
  Future<void> call({
    CreateNoteParams? params,
  }) async {
    if (params != null) {
      await _noteRepository.saveNote(
        title: params.title,
        body: params.body,
        noteModel: params.noteModel,
      );
    }
  }
}

class CreateNoteParams {
  CreateNoteParams({
    required this.title,
    required this.body,
    this.noteModel,
  });

  final String title;
  final String body;
  final NoteModel? noteModel;
}
