import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class CommentTextWidget extends StatefulWidget {
  const CommentTextWidget({
    super.key,
  });

  @override
  State<CommentTextWidget> createState() => _CommentTextWidgetState();
}

class _CommentTextWidgetState extends State<CommentTextWidget> {
  bool _isMore = false;

  void _moreComment() {
    print('jb : $_isMore');
    setState(() {
      _isMore = !_isMore;
    });
    print('jb : $_isMore');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _moreComment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Real Junbang',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gaps.v3,
          Text(
            overflow: _isMore ? TextOverflow.visible : TextOverflow.ellipsis,
            maxLines: _isMore ? null : 2,
            'This example demonstrates how to use showModalBottomSheet to display a bottom sheet that obscures the content behind it when a user taps a button.',
            style: const TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
