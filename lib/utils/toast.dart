import 'package:flutter/material.dart';

enum AlertType {
  success,
  error
}

class Toast {
  static void alert(BuildContext context, String message, AlertType type) {
    var scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: type == AlertType.success ? Colors.green : Colors.red,
        duration: const Duration(milliseconds: 1500),
      )
    );
  }
}