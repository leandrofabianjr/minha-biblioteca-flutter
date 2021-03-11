import 'package:flutter_modular/flutter_modular.dart';
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
    ChildRoute('/', child: (_, __) => LoginPage()),
    ChildRoute('/items', child: (_, __) => ItemsList()),
    ChildRoute(
      '/items/new',
      child: (_, args) => ItemsForm(),
    ),
    ChildRoute(
      '/items/:id',
      child: (_, args) => ItemsForm(id: args.params['id']),
    ),
  ];
}
