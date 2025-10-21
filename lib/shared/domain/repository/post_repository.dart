
import 'package:flutter_clean_riverpod/shared/data/model/post_model.dart';

abstract class PostRepository {
  Future<void> savePost(PostModel postModel);
  Future<PostModel?> getPost();
  Future<void> deletePost();
}
