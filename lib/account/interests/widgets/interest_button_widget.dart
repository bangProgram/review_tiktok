import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/utils.dart';

class InterestButtonWidget extends StatefulWidget {
  final String interest;
  final bool selected;

  const InterestButtonWidget(
      {super.key, required this.interest, required this.selected});

  @override
  State<InterestButtonWidget> createState() => _InterestButtonWidgetState();
}

class _InterestButtonWidgetState extends State<InterestButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.selected
            ? Theme.of(context).primaryColor
            : isDarkMode(context)
                ? Colors.grey.shade900
                : Colors.white,
        border: Border.all(
            color: isDarkMode(context)
                ? Colors.grey.shade900
                : Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size10,
            color: isDarkMode(context)
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.2),
          ),
        ],
        borderRadius: BorderRadius.circular(Sizes.size28),
      ),
      padding: const EdgeInsets.all(Sizes.size14),
      child: Text(
        widget.interest,
        style: const TextStyle(
          fontSize: Sizes.size16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
