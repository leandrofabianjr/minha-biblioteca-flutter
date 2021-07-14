import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minha_biblioteca/pages/login/login_store.dart';
import 'package:minha_biblioteca/components/toast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatelessWidget {
  final store = LoginStore();

  final _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            RoundedLoadingButton(
              controller: _btnController,
              onPressed: () => doLogin(context),
              child: Text('Login com Google'),
              color: Colors.red,
              successColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  void doLogin(BuildContext context) async {
    if (!await store.signInWithGoogle()) {
      _btnController.error();
      Timer(Duration(seconds: 1), () => _btnController.reset());
      ScaffoldMessenger.of(context).toast.error(
            message: 'Não foi possível fazer o login',
          );
    } else {
      _btnController.success();
    }
  }
}
