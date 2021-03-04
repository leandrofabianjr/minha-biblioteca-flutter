import 'package:flutter/material.dart';
import 'package:flutter_web_tests/pages/error/error_page.dart';
import 'package:flutter_web_tests/pages/loading/loading_page.dart';
import 'package:flutter_web_tests/pages/login/login_page.dart';

import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          // Initialize FlutterFire:
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorPage();
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return LoginPage();
            }

            return LoadingPage();
          },
        ));
  }
}
