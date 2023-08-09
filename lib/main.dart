import 'package:flutter/material.dart';
import 'package:review_tiktok/account/views/signup_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const SignupScreen(),
    );
  }
}
