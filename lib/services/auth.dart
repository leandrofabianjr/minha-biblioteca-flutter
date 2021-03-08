import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static bool get isUserLogged => currentUser != null;

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static Future<UserCredential> signInWithGoogle() async {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

    final GoogleAuthProvider googleProvider = GoogleAuthProvider();

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }
}
