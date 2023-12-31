import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/account/signup/view_models/signup_view_model.dart';
import 'package:review_tiktok/account/signup/views/username_screen.dart';
import 'package:review_tiktok/account/views/login_screen.dart';
import 'package:review_tiktok/account/widgets/button_widget.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/tutorial/views/privacy_policy_screen.dart';
import 'package:review_tiktok/tutorial/views/terms_of_service_screen.dart';

class SignupScreen extends ConsumerWidget {
  static const routeName = "signup";
  static const routeURL = "/";

  const SignupScreen({super.key});

  void _goLoginScreen(BuildContext context) {
    print('여기는 들어오니?');
    context.goNamed(LoginScreen.routeName);
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
        builder: (context) => const TermsOfServiceScreen(),
      ),
    );
  }

  void _goPolicyOf(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PrivacyPolicyScreen(),
      ),
    );
  }

// text: InlineSpan('By continuing, you agree to our Terms of Service and acknowledge that you have read our Privacy Policy to learn how we collect, use, and share your data.')

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
                buttonFunction: () async {
                  await ref
                      .read(signupVMProvider.notifier)
                      .githubSignup(context);
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
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Sizes.size14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(
                                    text:
                                        'and acknowledge that you have read our '),
                                TextSpan(
                                  text: 'Privacy Policy ',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => _goPolicyOf(context),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Sizes.size14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
