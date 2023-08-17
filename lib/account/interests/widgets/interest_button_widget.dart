import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/sizes.dart';

class InterestButtonWidget extends StatefulWidget {
  final String interest;
  const InterestButtonWidget({super.key, required this.interest});

  @override
  State<InterestButtonWidget> createState() => _InterestButtonWidgetState();
}

class _InterestButtonWidgetState extends State<InterestButtonWidget> {
  bool _isSelected = false;

  void _selectInterest() {
    _isSelected = !_isSelected;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectInterest,
      child: Container(
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
                blurRadius: Sizes.size10, color: Colors.black.withOpacity(0.2)),
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
      ),
    );
  }
}
