import "package:flutter_secure_storage/flutter_secure_storage.dart";

class AuthStorage {
  final _storage = FlutterSecureStorage();

  static const _tokenKey = "auth.jellyfinToken";
  static const _serverUrlKey = "auth.jellyfinServerUrl";
  
  Future<void> saveSession({
    required String token,
    required String serverUrl
  }) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _serverUrlKey, value: serverUrl);
  }

  Future<String?> getToken() {
    return _storage.read(key: _tokenKey);
  }
}
