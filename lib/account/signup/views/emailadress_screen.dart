import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/account/signup/view_models/signup_view_model.dart';
import 'package:review_tiktok/account/signup/views/password_screen.dart';
import 'package:review_tiktok/account/signup/widgets/nextpage_button_widget.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class EmailAdressScreen extends ConsumerStatefulWidget {
  const EmailAdressScreen({super.key});

  @override
  ConsumerState<EmailAdressScreen> createState() => _EmailAdressScreenState();
}

class _EmailAdressScreenState extends ConsumerState<EmailAdressScreen> {
  final TextEditingController _textController = TextEditingController();

  String _userEmail = "";
  String _errorMsg = "";
  bool _valid = false;

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
      if (_textController.text.isNotEmpty) {
        if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(_textController.text)) {
          _userEmail = _textController.text;
          _errorMsg = "";
          _validation();
        } else {
          _errorMsg = "Doesn't fit the email format";
          setState(() {});
        }
      }
    });
  }

  void _validation() {
    if (_userEmail != "" &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(_userEmail)) {
      _valid = true;
    } else {
      _valid = false;
    }
    setState(() {});
  }

  void _goNextPage() {
    if (_valid) {
      ref.read(signupState.notifier).state = {"email": _userEmail};
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const PasswordScreen(),
        ),
      );
    } else {
      return;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
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
                  'Create with your Email',
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v16,
                Text(
                  'You can valdate account.',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
                Gaps.v32,
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: _goNextPage,
                  controller: _textController,
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: Sizes.size3,
                  decoration: InputDecoration(
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
                    hintText: ' Input your Email',
                  ),
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
