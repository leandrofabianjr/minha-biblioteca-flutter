import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/services/auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              onPressed: () async {
                final user = await Auth.signInWithGoogle();
                print(Auth.isUserLogged);
                if (user != null) {
                  Modular.to.navigate('/items');
                }
              },
              child: Text('Login com Google'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
