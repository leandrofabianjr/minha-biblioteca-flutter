import 'package:flutter/material.dart';

class Toast {
  final ScaffoldMessengerState? _scaffoldMessengerState;

  Toast(this._scaffoldMessengerState);

  void _showToast({
    required IconData icon,
    required String message,
    required Color color,
    SnackBarAction? action,
  }) {
    final foregroundColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.dark
            ? Colors.white
            : Colors.black;

    _scaffoldMessengerState?.removeCurrentSnackBar();
    _scaffoldMessengerState?.showSnackBar(SnackBar(
      content: SafeArea(
        child: Row(
          children: [
            Icon(icon, color: foregroundColor),
            SizedBox(width: 8),
            Text(message, style: TextStyle(color: foregroundColor)),
          ],
        ),
      ),
      backgroundColor: color,
      action: action,
    ));
  }

  void error({
    String message = 'Desculpe! Algo deu errado',
    SnackBarAction? action,
  }) {
    _showToast(
      icon: Icons.error,
      message: message,
      color: Colors.red,
      action: action,
    );
  }

  void success({
    required String message,
    SnackBarAction? action,
  }) {
    _showToast(
      icon: Icons.check,
      message: message,
      color: Colors.green,
      action: action,
    );
  }
}

extension ToastExtension on ScaffoldMessengerState? {
  Toast get toast {
    return Toast(this!);
  }
}
