import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Theme.of(context).accentColor, size: 36),
          SizedBox(height: 16),
          Text('Algo deu errado', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
