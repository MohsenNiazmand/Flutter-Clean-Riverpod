import 'dart:async';

import 'package:flutter_clean_riverpod/domain/entities/local_data/secure_storage_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage implements SecureStorageEntity {
  SecureStorage({
    required this.storage,
  });

  final FlutterSecureStorage storage;

  @override
  Future<void> clear() async {
    await storage.deleteAll();
  }

  @override
  Future<String?> get(String key) async {
    return storage.read(key: key);
  }

  @override
  Future<int?> getInt(String key) async {
    var result = 0;
    try {
      await storage.read(key: key).then((value) async {
        result = int.parse(value ?? '0');
      });
    } catch (e) {
      return Future.error(e);
    }
    return result;
  }

  @override
  Future<bool> has(String key) async {
    return storage.containsKey(key: key);
  }

  @override
  Future<void> remove(String key) async {
    return storage.delete(key: key);
  }

  @override
  Future<void> set(String key, String? data) async {
    if (data == null) {
      return Future.error('Null Value');
    }
    return storage.write(key: key, value: data);
  }
}
