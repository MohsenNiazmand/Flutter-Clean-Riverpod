import 'package:flutter_clean_riverpod/core/utils/logger_helper.dart';
import 'package:flutter_clean_riverpod/shared/data/model/post_model.dart';
import 'package:hive/hive.dart';

class DatabaseHelper {
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  static const String postBoxName = 'postBox';
  static const String postKey = 'postData';

  Future<Box<PostModel>> get postBox async =>
      Hive.openBox<PostModel>(postBoxName);

  Future<void> insertPost(PostModel postModel) async {
    try {
      final box = await postBox;
      await box.put(postKey, postModel);
    } catch (e) {
      LoggerHelper.errorLog(e);
    }
  }

  Future<PostModel?> getPost() async {
    try {
      final box = await postBox;
      return box.get(postKey);
    } catch (e) {
      LoggerHelper.errorLog(e);
    }
    return null;
  }

  Future<void> deletePost() async {
    try {
      final box = await postBox;
      await box.delete(postKey);
    } catch (e) {
      LoggerHelper.errorLog(e);
    }
  }
}
