import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'local_storage.dart';

class FlutterSecurityStorage implements LocalStorage {
  final storage = const FlutterSecureStorage();
  @override
  Future<void> delete(String key) async {
    try {
      await storage.delete(key: key);
    } catch (e) {
      throw Exception('Error deleting value for key: $key');
    }
  }

  @override
  Future<String?> read(String key) async {
    try {
      return await storage.read(key: key);
    } catch (e) {
      throw Exception('Error reading value for key: $key');
    }
  }

  @override
  Future<void> save(String key, String value) async {
    try {
      await storage.write(key: key, value: value);
    } catch (e) {
      throw Exception('Error saving value for key: $key');
    }
  }
}
