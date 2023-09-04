import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final XFile file;
  final bool isPicked;

  const VideoPreviewScreen(
      {super.key, required this.file, required this.isPicked});

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController =
      VideoPlayerController.file(
    File(widget.file.path),
  );

  bool _playerInit = false;
  bool? _recordSaved = false;

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

  Future<void> _onGallerySave() async {
    _recordSaved = await GallerySaver.saveVideo(
      widget.file.path,
      albumName: 'TikTok Clone',
    );
    setState(() {});
  }

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
          if (!widget.isPicked)
            IconButton(
              onPressed: _onGallerySave,
              icon: FaIcon(
                _recordSaved!
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.download,
                color: _recordSaved! ? Colors.green : Colors.black,
              ),
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
