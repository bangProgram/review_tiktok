import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/sizes.dart';

class NextPageButtonWidget extends StatelessWidget {
  final Function() funtcion;
  final String text;
  final bool valid;

  const NextPageButtonWidget({
    super.key,
    required this.funtcion,
    required this.text,
    required this.valid,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funtcion,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
        decoration: BoxDecoration(
          color: valid ? Theme.of(context).primaryColor : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(Sizes.size8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: valid ? Colors.white : Colors.black,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
