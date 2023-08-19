import 'package:flutter/material.dart';
import 'package:review_tiktok/navigation/videopost/widgets/video_post_widget.dart';

class VideoPostPageWidget extends StatefulWidget {
  const VideoPostPageWidget({super.key});

  @override
  State<VideoPostPageWidget> createState() => _VideoPostPageWidgetState();
}

class _VideoPostPageWidgetState extends State<VideoPostPageWidget> {
  final PageController _pageController = PageController();

  void _initPageController() {
    _pageController.addListener(() {
      var test = _pageController.page!.round();
      print('jb1 : ${_pageController.page}');
      print('jb2 : ${_pageController.viewportFraction}');
      print('jb3 : $test');
    });
  }

  @override
  void initState() {
    super.initState();
    _initPageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return VideoPostWidget(
              pageIndex: index,
            );
          },
        ),
      ),
    );
  }
}
