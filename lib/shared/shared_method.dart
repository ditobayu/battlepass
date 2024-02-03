import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3),
  ).show(context);
}
