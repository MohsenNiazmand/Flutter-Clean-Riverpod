

import 'package:flutter_clean_riverpod/shared/data/model/post_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/repository/post_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class SavePostUseCase implements UseCase<void, PostModel> {
  SavePostUseCase(this._postRepository);

  final PostRepository _postRepository;

  @override
  Future<void> call({
    PostModel? params,
  }) async {
    await _postRepository.savePost(params ?? PostModel());
  }
}
