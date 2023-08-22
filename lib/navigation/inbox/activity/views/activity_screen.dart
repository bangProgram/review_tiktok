import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  bool _showBarrier = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
  );

  late final Animation<double> _rotateAnimation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

  late final Animation<Offset> _slideAnimation = Tween(
    begin: const Offset(0.0, -1.0),
    end: const Offset(0.0, 0.0),
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation =
      ColorTween(begin: Colors.transparent, end: Colors.black54)
          .animate(_animationController);

  final List<String> _tiles = List.generate(15, (index) => "$index m");

  final List<Map<String, dynamic>> _taps = [
    {
      "icon": FontAwesomeIcons.solidMessage,
      "title": 'All activity',
    },
    {
      "icon": FontAwesomeIcons.solidHeart,
      "title": 'Likes',
    },
    {
      "icon": FontAwesomeIcons.solidComment,
      "title": 'Comments',
    },
    {
      "icon": FontAwesomeIcons.at,
      "title": 'Mentions',
    },
    {
      "icon": FontAwesomeIcons.solidUser,
      "title": 'Followers',
    },
    {
      "icon": FontAwesomeIcons.tiktok,
      "title": 'From TikTok',
    },
  ];

  void _onDismissed(DismissDirection direction, String key) {
    setState(() {
      _tiles.remove(key);
    });
  }

  void _onAnimated() async {
    if (_rotateAnimation.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GestureDetector(
          onTap: _onAnimated,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'All Activity',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.h8,
              RotationTransition(
                turns: _rotateAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                  horizontal: Sizes.size18,
                ),
                child: Text(
                  'New',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              for (var tile in _tiles)
                Dismissible(
                  onDismissed: (direction) => _onDismissed(direction, tile),
                  key: Key(tile),
                  background: Container(
                    padding: const EdgeInsets.only(left: Sizes.size14),
                    alignment: Alignment.centerLeft,
                    color: Colors.green,
                    child: const FaIcon(
                      FontAwesomeIcons.checkDouble,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    padding: const EdgeInsets.only(right: Sizes.size14),
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const FaIcon(
                      FontAwesomeIcons.trash,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size14,
                    leading: Container(
                      width: Sizes.size44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.tiktok,
                          color: Colors.black,
                          size: Sizes.size20,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'TikTok : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text:
                                "You've registered to attend lnsects with MJ! ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' $tile',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                )
            ],
          ),
          if (_showBarrier) AnimatedModalBarrier(color: _barrierAnimation),
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      Sizes.size10,
                    ),
                    bottomRight: Radius.circular(
                      Sizes.size10,
                    ),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _taps)
                    ListTile(
                      title: Row(
                        children: [
                          FaIcon(
                            tab['icon'],
                            color: Colors.black,
                            size: Sizes.size14,
                          ),
                          Gaps.h14,
                          Text(
                            tab['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
