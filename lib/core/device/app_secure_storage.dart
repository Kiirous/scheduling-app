import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage {

  const AppSecureStorage(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> getSessionToken() {
    return Future.value('r:7bf1c9dfe9bc3c75d53c2af684f7bd32');
    return _secureStorage.read(key: 'sessionToken');
  }
}