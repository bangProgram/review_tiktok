import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/account/interests/views/interest_screen.dart';
import 'package:review_tiktok/account/login/widgets/login_button_widget.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final Map<String, dynamic> _userData = {};

  void _onLoginPress() {
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();
      context.goNamed(InterestScreen.routeName);
    }
    return;
  }

  void _focusOut() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _focusOut,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Login'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.circleQuestion),
            )
          ],
        ),
        body: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.all(
              Sizes.size24,
            ),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: ' Email',
                  ),
                  onSaved: (newValue) {
                    _userData['email'] = newValue;
                  },
                  validator: (value) {
                    if (value != "") {
                      return null;
                    }
                    return 'Input your Email';
                  },
                ),
                Gaps.v24,
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: ' Password',
                  ),
                  onSaved: (newValue) {
                    _userData['password'] = newValue;
                  },
                  validator: (value) {
                    if (value != "") {
                      if (value!.length > 5) {
                        return null;
                      }
                    }
                    return 'Check your Password type';
                  },
                ),
                Gaps.v32,
                LoginButtonWidget(
                  funtcion: _onLoginPress,
                  text: 'Log in',
                  valid: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
