import 'package:flutter/material.dart';
import 'package:review_tiktok/account/interests/widgets/interest_button_widget.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/tutorial/views/tutorial_main_screen.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class _InterestScreenState extends State<InterestScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _appbarInvisible = true;
  final List<String> _selectList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollAndAppbarVisible();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onNextActive(String interest) {
    setState(() {
      _selectList.add(interest);
      print(_selectList);
    });
  }

  void _scrollAndAppbarVisible() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 85) {
        _appbarInvisible = false;
      } else {
        _appbarInvisible = true;
      }
      setState(() {});
    });
  }

  void _goNextPage() {
    if (_selectList.isNotEmpty) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const TutorialMainScreen(),
        ),
        (route) => false,
      );
    } else {
      return;
    }
  }

  void _onSkipPressed() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const TutorialMainScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AnimatedOpacity(
          opacity: _appbarInvisible ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: const Text(
            'Choose Your interests',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose your interests',
                  style: TextStyle(
                    fontSize: Sizes.size36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Get better video recommendations',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w500,
                    )),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
                  child: Wrap(
                    runSpacing: Sizes.size20,
                    spacing: Sizes.size12,
                    children: [
                      for (var interest in interests)
                        InterestButtonWidget(
                          interest: interest,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _onSkipPressed,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size10,
                    horizontal: Sizes.size56,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(
                      Sizes.size3,
                    ),
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Gaps.h12,
              GestureDetector(
                onTap: _goNextPage,
                child: Opacity(
                  opacity: _selectList.isNotEmpty ? 1 : 0.4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                      horizontal: Sizes.size56,
                    ),
                    decoration: BoxDecoration(
                      color: _selectList.isNotEmpty
                          ? Colors.transparent
                          : Colors.grey.shade400,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(
                        Sizes.size3,
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
