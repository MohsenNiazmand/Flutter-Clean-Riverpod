
import 'package:flutter_clean_riverpod/shared/data/model/post_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/repository/post_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';

class GetPostUseCase implements UseCase<PostModel?, dynamic> {
  GetPostUseCase(this._postRepository);

  final PostRepository _postRepository;

  @override
  Future<PostModel?> call({
    dynamic params,
  }) async {
    return _postRepository.getPost();
  }
}
