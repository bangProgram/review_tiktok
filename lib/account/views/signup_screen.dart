import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/account/signup/views/username_screen.dart';
import 'package:review_tiktok/account/views/login_screen.dart';
import 'package:review_tiktok/account/widgets/button_widget.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  void _goLoginScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _goSignupByEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.size20, horizontal: Sizes.size28),
          child: Column(
            children: [
              Gaps.v52,
              const Text(
                'Sign up for TikTok',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Gaps.v20,
              Text(
                'Create a profile. follow other accounts, make your own videos, and more',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.grey.shade600,
                ),
              ),
              Gaps.v32,
              ButtonWidget(
                buttonFunction: () => _goSignupByEmail(context),
                buttonIcon: FontAwesomeIcons.user,
                buttonText: 'Create with your email',
              ),
              Gaps.v16,
              ButtonWidget(
                buttonIcon: FontAwesomeIcons.facebook,
                buttonColor: const Color(0xff3772ea),
                buttonText: 'Continue with Facebook',
              ),
              Gaps.v16,
              ButtonWidget(
                buttonIcon: FontAwesomeIcons.apple,
                buttonText: 'Continue with Apple',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size44),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account?',
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.h10,
              GestureDetector(
                onTap: () => _goLoginScreen(context),
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
