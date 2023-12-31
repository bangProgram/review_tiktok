import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/account/login/view_models/login_view_model.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/discover/views/discover_screen.dart';
import 'package:review_tiktok/navigation/inbox/views/inbox_screen.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_user_vm.dart';
import 'package:review_tiktok/navigation/profile/views/user_profile_screen.dart';
import 'package:review_tiktok/navigation/videopost/views/video_timeline_screen.dart';
import 'package:review_tiktok/navigation/videorecord/views/video_recode_screen.dart';
import 'package:review_tiktok/navigation/widgets/main_nav_button_widget.dart';
import 'package:review_tiktok/utils.dart';

class MainNavScreen extends ConsumerStatefulWidget {
  static const routeName = "home";
  static const routeURL = "/inbox";

  final String tab;
  const MainNavScreen({super.key, required this.tab});

  @override
  ConsumerState<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends ConsumerState<MainNavScreen> {
  List<String> tabs = [
    'home',
    'discover',
    'videopost',
    'inbox',
    'profile',
  ];

  late int _currentPage = tabs.indexOf(widget.tab);

  void _pageSelect(int index) {
    if (tabs[index] == 'profile') {
      final userModel = ref.read(loginVMProvider).value;
      if (userModel != null) {
        ref.read(profileUserProvider.notifier).reloadProfileByModel(userModel);
      } else {
        return;
      }
    }
    setState(() {
      _currentPage = index;
      context.go('/${tabs[index]}');
    });
  }

  void _goVideoPost() {
    context.pushNamed(VideoRecordScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    print('JB NAV _currentPage == 0 : $_currentPage // ${_currentPage == 0}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            Offstage(
              offstage: _currentPage != 0,
              child: VideoTimelineScreen(
                navSelected: _currentPage == 0,
              ),
            ),
            Offstage(
              offstage: _currentPage != 1,
              child: const DiscoverScreen(),
            ),
            Offstage(
              offstage: _currentPage != 2,
              child: Container(),
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
        color: _currentPage == 0 || isDarkMode(context)
            ? Colors.black
            : Colors.white,
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
                        inverted: _currentPage == 0 || isDarkMode(context),
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
                        inverted: _currentPage == 0 || isDarkMode(context),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: _goVideoPost,
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
                                color: _currentPage == 0 || isDarkMode(context)
                                    ? Colors.white
                                    : Colors.black,
                                borderRadius:
                                    BorderRadius.circular(Sizes.size9),
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.plus,
                                  color:
                                      _currentPage == 0 || isDarkMode(context)
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
                        inverted: _currentPage == 0 || isDarkMode(context),
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
                        inverted: _currentPage == 0 || isDarkMode(context),
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
