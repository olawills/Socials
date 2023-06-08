import 'package:flutter/material.dart';

void showAlert(
    {required BuildContext context,
    required String message,
    TextStyle? style}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: style,
      ),
    ),
  );
}
