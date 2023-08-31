import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final XFile file;

  const VideoPreviewScreen({super.key, required this.file});

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController =
      VideoPlayerController.file(
    File(widget.file.path),
  );

  bool _playerInit = false;

  @override
  void initState() {
    super.initState();
    initVideoPlayer();
  }

  Future<void> initVideoPlayer() async {
    await _videoPlayerController.initialize();
    _playerInit = _videoPlayerController.value.isInitialized;
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
    setState(() {});
  }

  void _onGallerySave() {}

  @override
  void dispose() {
    _videoPlayerController.dispose();
    File(widget.file.path).delete();
    print('Video Preview Screen Dispose !!!');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Preview Video!'),
        actions: [
          IconButton(
            onPressed: _onGallerySave,
            icon: const FaIcon(FontAwesomeIcons.download),
          ),
        ],
      ),
      body: _playerInit
          ? VideoPlayer(_videoPlayerController)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
