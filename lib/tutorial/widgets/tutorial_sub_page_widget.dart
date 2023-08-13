import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

enum Param { title, text, bold }

class TutorialSubPageWidget extends StatelessWidget {
  final List<Map<Param, String>> textList;

  TutorialSubPageWidget({
    super.key,
    required this.textList,
  });

  List<TextStyle> textStyle = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var text in textList) ...{
            Gaps.v16,
            Text(
              text['title']!,
              style: const TextStyle(
                fontSize: Sizes.size28,
                fontWeight: FontWeight.normal,
              ),
            ),
          }
        ],
      ),
    );
  }
}
