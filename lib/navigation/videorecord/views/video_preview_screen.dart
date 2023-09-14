import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/videorecord/view_models/video_upload_vm.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile file;
  final bool isPicked;

  const VideoPreviewScreen(
      {super.key, required this.file, required this.isPicked});

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController =
      VideoPlayerController.file(
    File(widget.file.path),
  );

  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));
  late final Animation<Color?> _barrierAnimation =
      ColorTween(begin: Colors.transparent, end: Colors.black.withOpacity(0.7))
          .animate(_animationController);
  late final Animation<double> _fromAnimation =
      Tween(begin: 0.0, end: 1.0).animate(_animationController);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Map<String, dynamic> _videoForm = {};

  bool _playerInit = false;
  bool? _recordSaved = false;
  bool _isUpload = false;
  bool _isBarrier = false;

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

  void _uploadPressed() async {
    print('JB : $_isBarrier');
    if (_isBarrier) {
      await _animationController.reverse();
    } else {
      _animationController.forward();

      _formkey.currentState!.reset();
    }

    setState(() {
      _isBarrier = !_isBarrier;
    });
  }

  void uploadVideo() async {
    FocusScope.of(context).unfocus();
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      _isUpload = true;
      final file = File(widget.file.path);
      await ref
          .read(videoUploadProvider.notifier)
          .uploadVideo(context, file, _videoForm);
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    File(widget.file.path).delete();
    print('Video Preview Screen Dispose !!!');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Preview Video!'),
          actions: [
            IconButton(
              onPressed: ref.watch(videoUploadProvider).isLoading
                  ? () {}
                  : _isUpload
                      ? () {}
                      : _uploadPressed,
              icon: ref.watch(videoUploadProvider).isLoading
                  ? const CircularProgressIndicator()
                  : FaIcon(
                      FontAwesomeIcons.cloudArrowUp,
                      color: _isUpload ? Colors.green.shade400 : Colors.black,
                    ),
            ),
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
            ? Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_videoPlayerController),
                  if (_isBarrier)
                    Positioned.fill(
                      child: AnimatedModalBarrier(
                        color: _barrierAnimation,
                        dismissible: true,
                        onDismiss: () {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                  Positioned(
                    child: IgnorePointer(
                      ignoring: (!_isBarrier ||
                          ref.read(videoUploadProvider).isLoading),
                      child: FadeTransition(
                        opacity: _fromAnimation,
                        child: Form(
                          key: _formkey,
                          child: Container(
                            width: screenW * 0.7,
                            height: screenH * 0.4,
                            padding: const EdgeInsets.only(
                              top: Sizes.size20,
                              bottom: Sizes.size5,
                              left: Sizes.size14,
                              right: Sizes.size14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(Sizes.size14),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return '제목을 입력해주세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    _videoForm['title'] = newValue;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: '제목',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(Sizes.size8),
                                      ),
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                Gaps.v6,
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 6,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return '설명을 입력해주세요';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      _videoForm['descript'] = newValue;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: '설명',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Sizes.size8),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: TextButton(
                                          onPressed: uploadVideo,
                                          child: const Text('저장'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: TextButton(
                                          onPressed: _uploadPressed,
                                          child: const Text(
                                            '취소',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
