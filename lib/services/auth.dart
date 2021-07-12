import 'package:minha_biblioteca/models/user.dart';
import 'package:minha_biblioteca/services/google_sign_in_service.dart';
import 'package:minha_biblioteca/services/users_service.dart';

class Auth {
  static bool get isUserLogged => GoogleSignInService().currentUser != null;

  static Future<User?> get currentUser async {
    final googleUid = GoogleSignInService().currentUser?.id;
    if (googleUid == null) return null;
    return await UsersService().getByGoogleUid(googleUid: googleUid);
  }

  static Future<User?> signInWithGoogle() async {
    final account = await GoogleSignInService().signIn();
    print(account);
    if (account == null) return null;

    final user = await currentUser;
    print(user);
    if (user != null) return user;

    try {
      final newUser = await UsersService().create(
        googleUid: account.id,
        email: account.email,
        name: account.displayName ?? account.email,
        profilePictureUrl: account.photoUrl,
      );
      return newUser;
    } catch (e) {
      print('Erro ao criar novo usuário');
      print(e);
      return null;
    }
  }
}
