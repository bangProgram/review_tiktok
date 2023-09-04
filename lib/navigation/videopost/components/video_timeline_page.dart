import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/common/config/change_noti_config.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/generated/l10n.dart';
import 'package:review_tiktok/navigation/videopost/components/video_comment_page.dart';
import 'package:review_tiktok/navigation/videopost/widgets/video_timeline_button_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoTimelinePage extends StatefulWidget {
  final int pageIndex;
  final bool navSelected;

  const VideoTimelinePage({
    super.key,
    required this.pageIndex,
    required this.navSelected,
  });

  @override
  State<VideoTimelinePage> createState() => _VideoTimelinePageState();
}

class _VideoTimelinePageState extends State<VideoTimelinePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/pepe.mp4");

  bool _isPlaying = true;
  bool _isMore = false;
  bool _autoMute = changeNotiConfig.autoMute;

  @override
  void initState() {
    super.initState();
    _initVideoController();
    _initAnimationController();
    changeNotiConfig.addListener(() {
      _autoMute = changeNotiConfig.autoMute;
      setState(() {});
    });
  }

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1,
      upperBound: 1.5,
      value: 1.3,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _initVideoController() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (_videoPlayerController.value.isInitialized) {
      _visibiltyDetect;
    }
    setState(() {});
  }

  void _videoToggle() {
    if (_isPlaying) {
      _animationController.forward();
      _videoPlayerController.pause();
    } else {
      _animationController.reverse();
      _videoPlayerController.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _visibiltyDetect(VisibilityInfo info) {
    if (info.visibleFraction == 1 &&
        _isPlaying != false &&
        widget.navSelected) {
      _videoPlayerController.play();
    }
    if (info.visibleFraction == 0 && _isPlaying == true) {
      _videoToggle();
    }
  }

  void _onCommentPress(BuildContext context) {
    if (_videoPlayerController.value.isPlaying) {
      _videoToggle();
    }
    showModalBottomSheet(
      context: context,
      builder: (context) => const VideoCommentPage(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _moreText() {
    setState(() {
      _isMore = !_isMore;
    });
  }

  @override
  void dispose() {
    print('jb ${widget.pageIndex} Page : dispose! ');
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return VisibilityDetector(
      key: Key('_detectKey_${widget.pageIndex}'),
      onVisibilityChanged: _visibiltyDetect,
      child: GestureDetector(
        onTap: _videoToggle,
        child: Stack(
          children: [
            Positioned.fill(
              child: VideoPlayer(
                _videoPlayerController,
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Transform.scale(
                  scale: _animationController.value,
                  child: AnimatedOpacity(
                    opacity: _isPlaying ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      size: Sizes.size52,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 20,
              child: IconButton(
                onPressed: changeNotiConfig.onToggleMute,
                icon: FaIcon(
                  _autoMute
                      ? FontAwesomeIcons.volumeOff
                      : FontAwesomeIcons.volumeHigh,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: Sizes.size72,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: Sizes.size24 + Sizes.size2,
                      backgroundImage: NetworkImage(
                        "https://blogpfthumb-phinf.pstatic.net/MjAyMjEyMjNfMTM5/MDAxNjcxNzgwNDg3ODk2.W8-NsFrT3zCfQ05ihG2bvTSoFjuy09UmWiCEmmt2FJog.zlsF-YkJ88u4dXmTP1ofrWUiij4eAlp8mXzvYybAnW0g.JPEG.asdroto/KakaoTalk_20221223_162730416.jpg/KakaoTalk_20221223_162730416.jpg",
                      ),
                    ),
                  ),
                  Gaps.v20,
                  const VideoTimelintButtonWidget(
                    icon: FontAwesomeIcons.solidHeart,
                    text: '2.9M',
                  ),
                  Gaps.v20,
                  GestureDetector(
                    onTap: () => _onCommentPress(context),
                    child: VideoTimelintButtonWidget(
                      icon: FontAwesomeIcons.solidComment,
                      text: S.of(context).commentCount(331000),
                    ),
                  ),
                  Gaps.v20,
                  const VideoTimelintButtonWidget(
                    icon: FontAwesomeIcons.share,
                    text: 'Share',
                  ),
                ],
              ),
            ),
            Positioned(
              width: screenWidth,
              bottom: Sizes.size20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '@Junbang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  const Text(
                    'This is actually the place',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gaps.v10,
                  GestureDetector(
                    onTap: _moreText,
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.65,
                          child: Text(
                            overflow: _isMore
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            maxLines: _isMore ? null : 1,
                            '#googleearth #googlemaps #googlemaps #googlemaps #googleearth #googlemaps #googlemaps #googleearth #googlemaps #googlemaps',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
