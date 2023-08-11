import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/account/views/emailadress_screen.dart';
import 'package:review_tiktok/account/widgets/nextpage_button_widget.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _textController = TextEditingController();

  String _userName = "";
  bool _valid = false;

  void _focusOut(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      _userName = _textController.text;
      _validUserName();
    });
  }

  void _validUserName() {
    print('$_userName / ${_userName.length}');
    if (_userName != "" && _userName.length >= 3) {
      _valid = true;
    } else {
      _valid = false;
    }
    setState(() {});
  }

  void _goNextPage() {
    if (_valid) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const EmailAdressScreen(),
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              Sizes.size24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: Sizes.size18,
                      ),
                    ),
                    const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const FaIcon(FontAwesomeIcons.circleQuestion),
                  ],
                ),
                Gaps.v28,
                const Text(
                  'Create username',
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v16,
                Text(
                  'You can always change this later.',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
                Gaps.v32,
                TextField(
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
                    hintText: ' Input Username',
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
