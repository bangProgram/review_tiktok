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
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 255, 68, 55),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          scaffoldBackgroundColor: Colors.white),
      home: const SignupScreen(),
    );
  }
}
