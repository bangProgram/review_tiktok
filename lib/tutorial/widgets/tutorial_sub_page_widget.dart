import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class TutorialSubPageWidget extends StatelessWidget {
  final String title;
  final List<String> subscriptList;

  const TutorialSubPageWidget({
    super.key,
    required this.title,
    required this.subscriptList,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.v16,
          Text(
            title,
            style: const TextStyle(
              fontSize: Sizes.size28,
              fontWeight: FontWeight.bold,
            ),
          ),
          for (var subscript in subscriptList) ...{
            Gaps.v16,
            Text(
              subscript,
              style: const TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
          }
        ],
      ),
    );
  }
}
