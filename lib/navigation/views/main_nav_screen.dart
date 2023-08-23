import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/discover/views/discover_screen.dart';
import 'package:review_tiktok/navigation/inbox/views/inbox_screen.dart';
import 'package:review_tiktok/navigation/profile/views/user_profile_screen.dart';
import 'package:review_tiktok/navigation/videopost/views/video_timeline_screen.dart';
import 'package:review_tiktok/navigation/widgets/main_nav_button_widget.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentPage = 4;

  void _pageSelect(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  List container = [
    Container(
      child: Transform.translate(
          offset: const Offset(0, 10), child: const Center(child: Text('화면1'))),
    ),
    Container(
      child: Transform.translate(
          offset: const Offset(0, 30), child: const Center(child: Text('화면2'))),
    ),
    Container(
      child: Transform.translate(
          offset: const Offset(0, 50), child: const Center(child: Text('화면3'))),
    ),
    Container(
      child: Transform.translate(
          offset: const Offset(0, 70), child: const Center(child: Text('화면4'))),
    ),
    Container(
      child: Transform.translate(
          offset: const Offset(0, 90), child: const Center(child: Text('화면5'))),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            Offstage(
              offstage: _currentPage != 0,
              child: const VideoTimelineScreen(),
            ),
            Offstage(
              offstage: _currentPage != 1,
              child: const DiscoverScreen(),
            ),
            Offstage(
              offstage: _currentPage != 2,
              child: container[2],
            ),
            Offstage(
              offstage: _currentPage != 3,
              child: const InboxScreen(),
            ),
            Offstage(
              offstage: _currentPage != 4,
              child: const UserProfileScreen(),
            ),
          ],
        ),
      ),
      //깃허브용 주석
      bottomNavigationBar: BottomAppBar(
        color: _currentPage == 0 ? Colors.black : Colors.white,
        child: Container(
          padding: const EdgeInsets.all(
            Sizes.size10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pageSelect(0),
                      child: MainNavButtonWidget(
                        icon: FontAwesomeIcons.house,
                        label: 'Home',
                        selected: _currentPage == 0,
                        inverted: _currentPage == 0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pageSelect(1),
                      child: MainNavButtonWidget(
                        icon: FontAwesomeIcons.magnifyingGlass,
                        label: 'Discover',
                        selected: _currentPage == 1,
                        inverted: _currentPage == 0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pageSelect(2),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Gaps.v48,
                          Positioned(
                            right: 27,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.circular(Sizes.size9),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 27,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.circular(Sizes.size9),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              height: 30,
                              width: 40,
                              decoration: BoxDecoration(
                                color: _currentPage == 0
                                    ? Colors.white
                                    : Colors.black,
                                borderRadius:
                                    BorderRadius.circular(Sizes.size9),
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: _currentPage == 0
                                      ? Colors.black
                                      : Colors.white,
                                  size: Sizes.size18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pageSelect(3),
                      child: MainNavButtonWidget(
                        icon: FontAwesomeIcons.message,
                        label: 'Inbox',
                        selected: _currentPage == 3,
                        inverted: _currentPage == 0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pageSelect(4),
                      child: MainNavButtonWidget(
                        icon: FontAwesomeIcons.user,
                        label: 'Profile',
                        selected: _currentPage == 4,
                        inverted: _currentPage == 0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
