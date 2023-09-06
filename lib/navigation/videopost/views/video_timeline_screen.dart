import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/videopost/components/video_timeline_page.dart';
import 'package:review_tiktok/navigation/videopost/vm/timeline_config_vm.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  final bool navSelected;

  const VideoTimelineScreen({super.key, required this.navSelected});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
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
    return ref.watch(timelineVmProvider).when(
          data: (video) {
            return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: video.length,
              itemBuilder: (context, index) {
                return VideoTimelinePage(
                  navSelected: widget.navSelected,
                  pageIndex: index,
                  title: video[index].title,
                );
              },
            );
          },
          error: (error, stackTrace) => Center(
            child: Text('Error : $error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
