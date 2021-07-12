import 'package:google_sign_in/google_sign_in.dart';
import 'package:minha_biblioteca/env.dart';

class GoogleSignInService {
  static final _singleton = GoogleSignInService._internal();

  late GoogleSignIn _googleSignIn;

  factory GoogleSignInService() {
    return _singleton;
  }

  GoogleSignInService._internal() {
    print('+------------------------------+');
    print('| Building GoogleSignInService |');
    print('+------------------------------+');

    _googleSignIn = GoogleSignIn(
      clientId: ENV['GOOGLE_CLIENT_ID'],
      scopes: <String>['email'],
    );
  }

  GoogleSignInAccount? get currentUser {
    return _googleSignIn.currentUser;
  }

  Future<GoogleSignInAccount?> signIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (e) {
      return null;
    }
  }
}
