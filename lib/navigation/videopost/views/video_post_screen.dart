import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/navigation/videopost/widgets/video_post_page_widget.dart';

class VideoPostScreen extends StatefulWidget {
  const VideoPostScreen({super.key});

  @override
  State<VideoPostScreen> createState() => _VideoPostScreenState();
}

class _VideoPostScreenState extends State<VideoPostScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: VideoPostPageWidget(),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            child: Column(
              children: [
                Text('위젯1'),
                Gaps.v28,
                Text('위젯2'),
                Gaps.v28,
                Text('위젯3'),
                Gaps.v28,
                Text('위젯4'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
