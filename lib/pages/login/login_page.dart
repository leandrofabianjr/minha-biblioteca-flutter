import 'package:flutter/material.dart';
import 'package:minha_biblioteca/pages/list_items/list_items_page.dart';
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
                await Auth.signInWithGoogle();
                print(Auth.currentUser);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => ListItemsPage()),
                );
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
