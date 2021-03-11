import 'package:flutter/material.dart';
import 'package:minha_biblioteca/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  runApp(ModularApp(module: AppModule(), child: MainWidget()));
}

class MainWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.pink,
      ),
      initialRoute: '/',
    ).modular();
  }
}
