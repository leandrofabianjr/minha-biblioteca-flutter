import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/services/auth.dart';

class AuthenticatedGuard implements RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    print('Vai ler auth');
    final isUserLogged = Auth.isUserLogged;
    print('Autenticado ${isUserLogged.toString()}');
    if (!isUserLogged) {
      await Modular.to.pushNamed('/');
    }
    return isUserLogged;
  }

  @override
  String? get guardedRoute => guardedRoute;
}
