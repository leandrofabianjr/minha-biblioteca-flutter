import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error),
          Text('Algo deu errado'),
        ],
      ),
    );
  }
}
