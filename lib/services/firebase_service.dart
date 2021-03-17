import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static bool get isUserLogged => currentUser != null;

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  // static Future<UserCredential> signInWithGoogle() async {
  //   await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  //   final GoogleAuthProvider googleProvider = GoogleAuthProvider();

  //   return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  // }

  static Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
