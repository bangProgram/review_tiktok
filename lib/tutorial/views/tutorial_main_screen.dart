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

  int _curPage = 0;

  void _pageCheck(int page) {
    _curPage = page;
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
            onPageChanged: _pageCheck,
            scrollDirection: Axis.vertical,
            children: [
              TutorialPageWidget(
                title: 'Swipe up',
                subscript:
                    'Videos are personalized for you based on what you watch, like, and share.',
                image: "assets/images/tutorial1.JPG",
                page: _curPage,
              ),
              TutorialPageWidget(
                title: 'Swipe up',
                subscript:
                    'Videos are personalized for you based on what you watch, like, and share.',
                image: "assets/images/tutorial2.JPG",
                page: _curPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
