import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class MainNavButtonWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final bool inverted;

  const MainNavButtonWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.inverted,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: selected ? 1 : 0.5,
      duration: const Duration(milliseconds: 300),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              color: inverted ? Colors.white : Colors.black,
              size: selected ? Sizes.size24 + Sizes.size1 : Sizes.size18,
            ),
            Gaps.v5,
            Text(
              label,
              style: TextStyle(
                color: inverted ? Colors.white : Colors.black,
                fontSize: selected ? Sizes.size14 : Sizes.size12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
