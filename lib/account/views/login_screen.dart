import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/account/login/view_models/login_view_model.dart';
import 'package:review_tiktok/account/login/views/login_form_screen.dart';
import 'package:review_tiktok/account/views/signup_screen.dart';
import 'package:review_tiktok/account/widgets/button_widget.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class LoginScreen extends ConsumerWidget {
  static const routeName = "login";
  static const routeURL = "/login";

  const LoginScreen({super.key});

  void _goSignupScreen(BuildContext context) {
    context.goNamed(SignupScreen.routeName);
  }

  void _goLoginForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.size20, horizontal: Sizes.size28),
          child: Column(
            children: [
              Gaps.v52,
              const Text(
                'Log in to TikTok',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Gaps.v20,
              Text(
                'Manage your account, check notifications, comment on videos, and more.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.grey.shade600,
                ),
              ),
              Gaps.v32,
              ButtonWidget(
                buttonFunction: () => _goLoginForm(context),
                buttonIcon: FontAwesomeIcons.user,
                buttonText: 'Use email & password',
              ),
              Gaps.v16,
              ButtonWidget(
                buttonFunction: () async {
                  await ref.read(loginVMProvider.notifier).githubLogin(context);
                },
                buttonIcon: FontAwesomeIcons.github,
                // buttonColor: const Color(0xff3772ea),
                buttonText: 'Continue with Github',
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
        // color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size44),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.h10,
              GestureDetector(
                onTap: () => _goSignupScreen(context),
                child: const Text(
                  'Sign up',
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
