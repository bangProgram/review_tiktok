import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/views/main_nav_screen.dart';

class TutorialPageWidget extends StatelessWidget {
  final String title, subscript, image;
  final int page;

  const TutorialPageWidget({
    super.key,
    required this.title,
    required this.subscript,
    required this.image,
    required this.page,
  });

  void _goMainNavigation(BuildContext context) {
    context.go(MainNavScreen.routeURL);
  }

  @override
  Widget build(BuildContext context) {
    print('jb page : $page');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v16,
        Text(
          title,
          style: const TextStyle(
            fontSize: Sizes.size36,
            fontWeight: FontWeight.w800,
          ),
        ),
        Gaps.v16,
        Text(
          subscript,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Sizes.size18 + Sizes.size1,
          ),
        ),
        Gaps.v20,
        Center(
          child: Image.asset(
            image,
            scale: 0.8,
          ),
        ),
        Gaps.v10,
        if (page == 1)
          GestureDetector(
            onTap: () => _goMainNavigation(context),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: Sizes.size14),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Sizes.size7),
                ),
                child: const Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
