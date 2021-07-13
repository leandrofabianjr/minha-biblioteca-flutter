import 'package:minha_biblioteca/models/user.dart';
import 'package:minha_biblioteca/services/google_sign_in_service.dart';
import 'package:minha_biblioteca/services/users_service.dart';

class Auth {
  static final _singleton = Auth._internal();

  User? _currentUser;

  factory Auth() {
    return _singleton;
  }

  Auth._internal() {
    print('+---------------+');
    print('| Building Auth |');
    print('+---------------+');
  }

  static bool get isUserLogged => GoogleSignInService().currentUser != null;

  Future<User?> get currentUser async {
    print('currentUser');
    print(_currentUser);
    if (_currentUser != null) return _currentUser;

    print('+---------------+');
    print('| Fetching user |');
    print('+---------------+');

    final googleUid = GoogleSignInService().currentUser?.id;
    if (googleUid == null) return null;
    _currentUser = await UsersService().getByGoogleUid(googleUid: googleUid);
    return _currentUser;
  }

  static Future<User?> signInWithGoogle() async {
    final account = await GoogleSignInService().signIn();
    if (account == null) return null;

    final user = await Auth().currentUser;
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
