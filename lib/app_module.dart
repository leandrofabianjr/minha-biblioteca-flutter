import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/guards/authenticated_guard.dart';
import 'package:minha_biblioteca/guards/not_authenticated_guard.dart';
import 'package:minha_biblioteca/pages/items_form/items_form_widgets.dart';
import 'package:minha_biblioteca/pages/items_list/items_list_widgets.dart';
import 'package:minha_biblioteca/pages/login/login_page.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      guards: [NotAuthenticatedGuard()],
      child: (_, __) => LoginPage(),
      guardedRoute: '/items',
    ),
    ChildRoute(
      '/items',
      guards: [AuthenticatedGuard()],
      child: (_, __) => ItemsList(),
      guardedRoute: '/',
    ),
    ChildRoute(
      '/items/new',
      guards: [AuthenticatedGuard()],
      child: (_, args) => ItemsForm(),
      guardedRoute: '/',
    ),
    ChildRoute(
      '/items/:id',
      guards: [AuthenticatedGuard()],
      child: (_, args) => ItemsForm(id: args.params['id']),
      guardedRoute: '/',
    ),
  ];
}
