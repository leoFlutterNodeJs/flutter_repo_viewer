import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer_reso/auth/infratructure/credential_storage/credential_storage.dart';

class GithubAuthentication {
  final CredentialsStorage _credentialsStorage;

  GithubAuthentication(this._credentialsStorage);

  bool _isValidStoredCredential(Credentials? storedCredentials) {
    return storedCredentials != null &&
        storedCredentials.canRefresh &&
        storedCredentials.isExpired;
  }

  Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialsStorage.read();
      if (_isValidStoredCredential(storedCredentials)) {
        // TODO: refresh
      }
      return storedCredentials;
    } on PlatformException {
      return null;
    }
  }

  Future<bool> isSignedIn() => getSignedInCredentials().then((credentials) => credentials != null); 

}
