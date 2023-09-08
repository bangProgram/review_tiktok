import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/account/signup/view_models/signup_view_model.dart';
import 'package:review_tiktok/account/signup/views/birthday_screen.dart';
import 'package:review_tiktok/account/signup/widgets/nextpage_button_widget.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController _textController = TextEditingController();

  String _userPassword = "";
  final String _errorMsg = "";
  bool _valid = false;
  bool _invisible = true;

  void _focusOut(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    _textEditing();
  }

  void _textEditing() {
    _textController.addListener(() {
      _userPassword = _textController.text;
      _validation();
    });
  }

  void _validation() {
    if (_userPassword != "" && _userPassword.length >= 8) {
      _valid = true;
    } else {
      _valid = false;
    }
    setState(() {});
  }

  void _clearText() {
    _textController.clear();
  }

  void _visibility() {
    _invisible = !_invisible;
    setState(() {});
  }

  void _goNextPage() {
    if (_valid) {
      final befState = ref.read(signupState.notifier).state;
      ref.read(signupState.notifier).state = {
        ...befState,
        "password": _userPassword
      };
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const BirthdayScreen(),
        ),
      );
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusOut(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Sign up'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.circleQuestion),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              Sizes.size24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v28,
                const Text(
                  'Create password',
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v16,
                Gaps.v32,
                TextField(
                  obscureText: _invisible,
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: _goNextPage,
                  controller: _textController,
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: Sizes.size3,
                  decoration: InputDecoration(
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _clearText,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: _userPassword != ""
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade400,
                            size: Sizes.size16,
                          ),
                        ),
                        Gaps.h10,
                        GestureDetector(
                          onTap: _visibility,
                          child: Icon(
                            _invisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: _invisible
                                ? Colors.grey.shade400
                                : Theme.of(context).primaryColor,
                            size: Sizes.size24,
                          ),
                        ),
                      ],
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    errorText: _errorMsg != "" ? _errorMsg : null,
                  ),
                ),
                Gaps.v14,
                const Text(
                  'Your password must have:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v16,
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.circleCheck,
                      color: _valid ? Colors.green : Colors.grey.shade600,
                      size: Sizes.size16 + Sizes.size1,
                    ),
                    Gaps.h10,
                    const Text(
                      '8 to 20 characters',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                      ),
                    ),
                  ],
                ),
                Gaps.v28,
                NextPageButtonWidget(
                  funtcion: () => _goNextPage(),
                  text: 'Go Next',
                  valid: _valid,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
