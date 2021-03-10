import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/pages/items_form/items_form_page.dart';
import 'package:minha_biblioteca/pages/items_list/items_list_page.dart';
import 'package:minha_biblioteca/pages/login/login_page.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => LoginPage()),
    ChildRoute('/items', child: (_, __) => ItemsListPage()),
    ChildRoute(
      '/items/new',
      child: (_, args) => ItemsFormPage(),
    ),
    ChildRoute(
      '/items/:id',
      child: (_, args) => ItemsFormPage(id: args.params['id']),
    ),
  ];
}
