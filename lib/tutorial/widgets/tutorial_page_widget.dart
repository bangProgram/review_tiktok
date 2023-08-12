import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class TutorialPageWidget extends StatelessWidget {
  final String title, subscript, image;

  const TutorialPageWidget({
    super.key,
    required this.title,
    required this.subscript,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}
