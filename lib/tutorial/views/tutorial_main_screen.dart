import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/tutorial/widgets/tutorial_page_widget.dart';

class TutorialMainScreen extends StatefulWidget {
  const TutorialMainScreen({super.key});

  @override
  State<TutorialMainScreen> createState() => _TutorialMainScreenState();
}

class _TutorialMainScreenState extends State<TutorialMainScreen> {
  final PageController _pageController = PageController();

  void _test(int page) {
    print(page);
    print(_pageController.position);
    print(_pageController.positions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.size36, horizontal: Sizes.size32),
          child: PageView(
            controller: _pageController,
            onPageChanged: _test,
            scrollDirection: Axis.vertical,
            children: const [
              TutorialPageWidget(
                title: 'Swipe up',
                subscript:
                    'Videos are personalized for you based on what you watch, like, and share.',
                image: "assets/images/tutorial1.JPG",
              ),
              TutorialPageWidget(
                title: 'Swipe up',
                subscript:
                    'Videos are personalized for you based on what you watch, like, and share.',
                image: "assets/images/tutorial2.JPG",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
