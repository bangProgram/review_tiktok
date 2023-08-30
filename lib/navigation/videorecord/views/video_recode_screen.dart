import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class VideoRecordScreen extends StatefulWidget {
  const VideoRecordScreen({super.key});

  @override
  State<VideoRecordScreen> createState() => _VideoRecordScreenState();
}

class _VideoRecordScreenState extends State<VideoRecordScreen> {
  late final CameraController _cameraController;

  bool _hasPermission = false;
  bool _camInit = false;

  @override
  void initState() {
    super.initState();
    _initPermission();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    bool isCamPermission =
        (cameraPermission.isDenied || cameraPermission.isPermanentlyDenied);
    bool isMicPermission =
        (micPermission.isDenied || micPermission.isPermanentlyDenied);

    if (!isCamPermission && !isMicPermission) {
      print('JB CAM In');
      _hasPermission = true;
      await _initCamera();
      setState(() {});
    }
  }

  Future<void> _initCamera() async {
    if (!_hasPermission) return;

    final camera = await availableCameras();
    if (camera.isEmpty) return;

    _cameraController = CameraController(camera[0], ResolutionPreset.ultraHigh);
    await _cameraController.initialize();
    _camInit = _cameraController.value.isInitialized;
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: screenW,
              height: screenH,
            ),
            Positioned.fill(
              child: Container(
                child: _hasPermission || _camInit
                    ? CameraPreview(_cameraController)
                    : const Center(
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
                      ),
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
          ],
        ),
      ),
    );
  }
}
