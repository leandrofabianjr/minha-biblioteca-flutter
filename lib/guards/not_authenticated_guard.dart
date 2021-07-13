import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/services/auth.dart';

class NotAuthenticatedGuard implements RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    final isUserNotLogged = !Auth.isUserLogged;
    print('Não autenticado ${isUserNotLogged.toString()}');
    if (!isUserNotLogged) {
      await Modular.to.pushNamed('/items');
    }
    return isUserNotLogged;
  }

  @override
  String? get guardedRoute => guardedRoute;
}
