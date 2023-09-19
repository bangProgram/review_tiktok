import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/videopost/components/video_timeline_page.dart';
import 'package:review_tiktok/navigation/videopost/vm/video_timeline_vm.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  final bool navSelected;

  const VideoTimelineScreen({super.key, required this.navSelected});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  final PageController _pageController = PageController();
  int _videoCnt = 0;
  @override
  void initState() {
    super.initState();
  }

  Future<void> reloadVideo(int index) async {
    if (index == _videoCnt - 1) {
      await ref.read(timelineProvider.notifier).reloadVideo();
    }
  }

  Future<void> refreshVideo() async {
    await ref.read(timelineProvider.notifier).refreshVideo();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          data: (video) {
            _videoCnt = video.length;
            return RefreshIndicator(
              onRefresh: refreshVideo,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: reloadVideo,
                itemCount: video.length,
                itemBuilder: (context, index) {
                  final videoData = video[index];
                  return VideoTimelinePage(
                    navSelected: widget.navSelected,
                    pageIndex: index,
                    videoData: videoData,
                  );
                },
              ),
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
