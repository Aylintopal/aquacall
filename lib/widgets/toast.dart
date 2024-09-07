import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void toast(BuildContext context, String msg) {
  toastification.show(
    primaryColor: Colors.red,
    progressBarTheme: const ProgressIndicatorThemeData(
      color: Colors.red,
      linearMinHeight: 1,
      linearTrackColor: Colors.blueGrey,
    ),
    context: context,
    title: Text(msg),
    autoCloseDuration: const Duration(seconds: 5),
  );
}
