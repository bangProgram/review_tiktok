import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPostWidget extends StatefulWidget {
  final int pageIndex;
  const VideoPostWidget({
    super.key,
    required this.pageIndex,
  });

  @override
  State<VideoPostWidget> createState() => _VideoPostWidgetState();
}

class _VideoPostWidgetState extends State<VideoPostWidget> {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/pepe.mp4");

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initVideoController();
  }

  @override
  void dispose() {
    print('jb ${widget.pageIndex} Page : dispose! ');
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _initVideoController() async {
    await _videoPlayerController.initialize();
    if (_videoPlayerController.value.isInitialized) {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      _isPlaying = _videoPlayerController.value.isPlaying;
    }
    setState(() {});
  }

  void _videoToggle() {
    if (_isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _videoToggle,
      child: VideoPlayer(
        _videoPlayerController,
      ),
    );
  }
}
