import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/account/signup/views/username_screen.dart';
import 'package:review_tiktok/account/views/login_screen.dart';
import 'package:review_tiktok/account/widgets/button_widget.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/tutorial/views/tutorial_sub_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  void _goLoginScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  void _goSignupByEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  void _goServiesOf(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TutorialSubScreen(),
      ),
    );
  }

// text: InlineSpan('By continuing, you agree to our Terms of Service and acknowledge that you have read our Privacy Policy to learn how we collect, use, and share your data.')

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
              Gaps.v20,
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 300,
                    child: Row(
                      children: [
                        Flexible(
                          child: RichText(
                            // overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                    text: 'By continuing, you agree to our '),
                                TextSpan(
                                  text: 'Terms of Service ',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => _goServiesOf(context),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: Sizes.size14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(
                                    text:
                                        'and acknowledge that you have read our '),
                                const TextSpan(
                                    text: 'Privacy Policy ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizes.size14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const TextSpan(
                                    text:
                                        'to learn how we collect, use, and share your data.'),
                              ],
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: Sizes.size12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
