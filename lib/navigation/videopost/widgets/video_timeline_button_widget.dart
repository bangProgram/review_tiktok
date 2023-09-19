import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class VideoTimelintButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool active;

  const VideoTimelintButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          FaIcon(
            icon,
            size: Sizes.size36,
            color: active ? Colors.red : Colors.white,
          ),
          Gaps.v5,
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
