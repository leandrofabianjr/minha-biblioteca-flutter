import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/services/auth.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  Future<bool> signInWithGoogle() async {
    final user = await Auth.signInWithGoogle();

    if (user == null) {
      return false;
    }

    Modular.to.navigate('/items');

    return true;
  }
}
