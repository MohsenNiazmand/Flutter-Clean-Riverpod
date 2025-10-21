
import 'package:flutter_clean_riverpod/shared/domain/repository/post_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class DeletePostUseCase implements UseCase<void, dynamic> {
  DeletePostUseCase(this._postRepository);

  final PostRepository _postRepository;

  @override
  Future<void> call({
    dynamic params,
  }) async {
    await _postRepository.deletePost();
  }
}
