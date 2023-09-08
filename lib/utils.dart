import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

void showFirebaseError(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Error Ocurred : ${(error as FirebaseException).message}"),
    ),
  );
}
