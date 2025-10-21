

import 'package:flutter_clean_riverpod/shared/data/local/database_helper.dart';
import 'package:flutter_clean_riverpod/shared/data/model/post_model.dart';
import 'package:flutter_clean_riverpod/shared/domain/repository/post_repository.dart';

class PostRepositoryImpl extends PostRepository {

  PostRepositoryImpl(this._databaseHelper);
  final DatabaseHelper _databaseHelper;

  @override
  Future<void> deletePost() async{
    await _databaseHelper.deletePost();
  }

  @override
  Future<PostModel?> getPost() async{
    return _databaseHelper.getPost();
  }

  @override
  Future<void> savePost(PostModel postModel) async{
    await _databaseHelper.insertPost(postModel);
  }

}
