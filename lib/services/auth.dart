import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static bool get isUserLogged => currentUser != null;

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static Future<UserCredential> signInWithGoogle() async {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

    final GoogleAuthProvider googleProvider = GoogleAuthProvider()
      ..addScope('https://www.googleapis.com/auth/contacts.readonly')
      ..setCustomParameters({'login_hint': 'user@example.com'});

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }
}
