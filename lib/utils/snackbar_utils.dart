import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: isError ? Colors.red : Colors.green,
  );

  if (ScaffoldMessenger.maybeOf(context) != null) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    
  }
}
