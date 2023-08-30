import 'package:flutter/material.dart';
import 'package:review_tiktok/navigation/videopost/components/video_timeline_page.dart';

class VideoTimelineScreen extends StatefulWidget {
  final bool navSelected;

  const VideoTimelineScreen({super.key, required this.navSelected});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return VideoTimelinePage(
          navSelected: widget.navSelected,
          pageIndex: index,
        );
      },
    );
  }
}
