import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/app_module.dart';
import 'package:minha_biblioteca/env.dart';
import 'package:minha_biblioteca/graphql/server.dart';
import 'package:minha_biblioteca/pages/error/error_page.dart';
import 'package:minha_biblioteca/pages/loading/loading_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:minha_biblioteca/services/auth.dart';

void main() async {
  runApp(ModularApp(module: AppModule(), child: MainWidget()));
}

class MainWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Firebase.initializeApp(),
        Server.init(ENV['ADMIN_PASS']!),
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: ErrorPage());
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final initialRoute = Auth.isUserLogged ? '/items' : '/';

          return GraphQLProvider(
            client: Server.client,
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: initialRoute,
            ).modular(),
          );
        }

        return Scaffold(body: LoadingPage());
      },
    );
  }
}
