import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/shared/data/model/post_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/post/delete_post_use_case.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/post/get_post_use_case.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/post/save_post_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_provider.g.dart';

@riverpod
class Post extends _$Post {
  PostModel? postModel;

  @override
  PostModel? build() {
    loadPost();
    return postModel;
  }

  Future<void> savePost(PostModel newPostModel) async {
    await getIt<SavePostUseCase>().call(params: newPostModel);
    postModel = newPostModel;
    state = postModel;
  }

  Future<PostModel> loadPost() async {
    postModel = await getIt<GetPostUseCase>().call();
    state = postModel;
    return postModel ?? PostModel();
  }

  Future<void> deletePost() async {
    await getIt<DeletePostUseCase>().call();
    postModel = null;
    state = postModel;
  }
}
