import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer_reso/auth/infratructure/credential_storage/credential_storage.dart';

class SecureCredentialsStorage implements CredentialsStorage {
  final FlutterSecureStorage _storage;
  SecureCredentialsStorage(this._storage);

  static const _key = 'oauth2_credentials';

  Credentials? _cacheCredentials;

  @override
  Future<Credentials?> read() async {
    if (_cacheCredentials != null) return _cacheCredentials;
    final json = await _storage.read(key: _key);
    if (json == null) return null;
    try {
      return _cacheCredentials = Credentials.fromJson(json);
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> save(Credentials credentials) async {
    _cacheCredentials = credentials;
    await _storage.write(key: _key, value: credentials.toJson());
  }

  @override
  Future<void> clear() async {
    _cacheCredentials = null;
    await _storage.delete(key: _key);
  }
}
