import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future setData(String key, String data) async {
    return await _storage.write(key: key, value: data);
  }

  static Future<String?> getToken(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> deleteToken(String key) async {
    return await _storage.delete(key: key);
  }
}
