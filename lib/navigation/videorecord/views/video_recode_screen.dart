import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/videorecord/views/video_preview_screen.dart';

class VideoRecordScreen extends StatefulWidget {
  const VideoRecordScreen({super.key});

  @override
  State<VideoRecordScreen> createState() => _VideoRecordScreenState();
}

class _VideoRecordScreenState extends State<VideoRecordScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late CameraController _cameraController;
  late final AnimationController _scaleAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
    lowerBound: 1.0,
    upperBound: 1.2,
  );
  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 10,
    ),
  );

  late final Animation<double> _progressAnimation =
      Tween(begin: 0.0, end: 1.0).animate(_progressAnimationController);

  bool _hasPermission = false;
  bool _camInit = false;
  bool _isSelfie = false;
  bool _isRecording = false;

  FlashMode _flashMode = FlashMode.auto;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initPermission();

    _progressAnimationController.addListener(() {
      setState(() {});
    });

    _progressAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          onRecordStartandStop();
        }
      },
    );
  }

  Future<void> _initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    bool isCamPermission =
        (cameraPermission.isDenied || cameraPermission.isPermanentlyDenied);
    bool isMicPermission =
        (micPermission.isDenied || micPermission.isPermanentlyDenied);

    if (!isCamPermission && !isMicPermission) {
      _hasPermission = true;
      await _initCamera();
      setState(() {});
    }
  }

  Future<void> _initCamera() async {
    if (!_hasPermission) return;
    final camera = await availableCameras();
    if (camera.isEmpty) return;
    _cameraController = CameraController(
      camera[_isSelfie ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );
    await _cameraController.initialize();
    _camInit = _cameraController.value.isInitialized;
    _flashMode = _cameraController.value.flashMode;
  }

  void _onRotateCam() {
    _isSelfie = !_isSelfie;
    _initCamera();
    setState(() {});
  }

  Future<void> _onCameraFlash(FlashMode newFlash) async {
    _flashMode = newFlash;
    await _cameraController.setFlashMode(_flashMode);
    setState(() {});
  }

  Future<void> onRecordStartandStop() async {
    _isRecording = !_isRecording;

    if (_isRecording) {
      _scaleAnimationController.forward();
      _progressAnimationController.forward();
      await _cameraController.startVideoRecording();
    } else {
      _scaleAnimationController.reverse();
      _progressAnimationController.reset();
      final XFile file = await _cameraController.stopVideoRecording();
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPreviewScreen(
            file: file,
            isPicked: false,
          ),
        ),
      );
    }
  }

  Future<void> _onVideoPicker() async {
    final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file == null) return;
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          file: file,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      if (!_camInit) return;
      _camInit = false;
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await _initCamera();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _scaleAnimationController.dispose();
    _progressAnimationController.dispose();
    print('Video Record Screen Dispose !!!');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: screenW,
              height: screenH,
            ),
            Positioned.fill(
              child: Container(
                child: !_hasPermission || !_camInit
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Initializing ...',
                              style: TextStyle(
                                fontSize: Sizes.size32,
                              ),
                            ),
                            Gaps.v16,
                            CircularProgressIndicator(),
                          ],
                        ),
                      )
                    : CameraPreview(_cameraController),
              ),
            ),
            Positioned(
              top: Sizes.size10,
              left: Sizes.size10,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const FaIcon(
                  FontAwesomeIcons.xmark,
                  color: Colors.white,
                  size: Sizes.size32,
                ),
              ),
            ),
            Positioned(
              top: Sizes.size10,
              right: Sizes.size14,
              child: Column(
                children: [
                  IconButton(
                    onPressed: _onRotateCam,
                    icon: const FaIcon(
                      FontAwesomeIcons.cameraRotate,
                      color: Colors.white,
                    ),
                  ),
                  Gaps.v14,
                  IconButton(
                    onPressed: () => _onCameraFlash(FlashMode.always),
                    icon: FaIcon(
                      Icons.flash_on_rounded,
                      color: _flashMode == FlashMode.always
                          ? Colors.yellow
                          : Colors.white,
                    ),
                  ),
                  Gaps.v14,
                  IconButton(
                    onPressed: () => _onCameraFlash(FlashMode.off),
                    icon: FaIcon(
                      Icons.flash_off_rounded,
                      color: _flashMode == FlashMode.off
                          ? Colors.yellow
                          : Colors.white,
                    ),
                  ),
                  Gaps.v14,
                  IconButton(
                    onPressed: () => _onCameraFlash(FlashMode.auto),
                    icon: FaIcon(
                      Icons.flash_auto_rounded,
                      color: _flashMode == FlashMode.auto
                          ? Colors.yellow
                          : Colors.white,
                    ),
                  ),
                  Gaps.v14,
                  IconButton(
                    onPressed: () => _onCameraFlash(FlashMode.torch),
                    icon: FaIcon(
                      Icons.flashlight_on,
                      color: _flashMode == FlashMode.torch
                          ? Colors.yellow
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: screenW,
              bottom: Sizes.size20,
              child: Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: onRecordStartandStop,
                    child: ScaleTransition(
                      scale: _scaleAnimationController,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: Sizes.size64,
                            height: Sizes.size64,
                            decoration: BoxDecoration(
                              color: Colors.red.shade300,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.6),
                                width: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Sizes.size64 + Sizes.size12,
                            height: Sizes.size64 + Sizes.size12,
                            child: CircularProgressIndicator(
                              color: Colors.red.shade300,
                              strokeWidth: 6,
                              value: _progressAnimation.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: _onVideoPicker,
                        icon: const FaIcon(
                          FontAwesomeIcons.image,
                          color: Colors.white,
                          size: Sizes.size24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
