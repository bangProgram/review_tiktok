import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/account/signup/view_models/signup_view_model.dart';
import 'package:review_tiktok/account/signup/widgets/nextpage_button_widget.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/utils.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  ConsumerState<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends ConsumerState<BirthdayScreen> {
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
    print('JB State 확인 : ${ref.read(signupState)}');
    ref.read(signupVMProvider.notifier).userSignup(context);
    // context.goNamed(InterestScreen.routeName);
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
                  style: TextStyle(
                    color: isDarkMode(context) ? Colors.white : Colors.black,
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
