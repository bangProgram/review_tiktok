import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/account/signup/widgets/nextpage_button_widget.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/tutorial/views/tutorial_main_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _textController = TextEditingController();
  final DateTime _initDate = DateTime(
    DateTime.now().year - 20,
    DateTime.now().month,
    DateTime.now().day,
  );
  String? _setDate;

  void _focusOut(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    _setDateTime();
  }

  void _setDateTime() {
    print(_initDate);
    _setDate = _initDate.toString().split(" ").first;
    _textController.value = TextEditingValue(text: _setDate!);
  }

  void _goNextPage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const TutorialMainScreen(),
      ),
      (route) => false,
    );
  }

  void _changeDate(DateTime date) {
    _setDate = date.toString().split(" ").first;
    _textController.value = TextEditingValue(text: _setDate!);
    setState(() {});
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
                  "When's your birthday?",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v16,
                Text(
                  "Your birthday won't be shown publicly.",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
                Gaps.v32,
                TextField(
                  enabled: false,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _textController,
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
                  ),
                ),
                Gaps.v28,
                NextPageButtonWidget(
                  funtcion: () => _goNextPage(),
                  text: 'Go Next',
                  valid: true,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 250,
            child: CupertinoDatePicker(
              initialDateTime: _initDate,
              mode: CupertinoDatePickerMode.date,
              dateOrder: DatePickerDateOrder.ymd,
              onDateTimeChanged: _changeDate,
              maximumDate: _initDate,
            ),
          ),
        ),
      ),
    );
  }
}
