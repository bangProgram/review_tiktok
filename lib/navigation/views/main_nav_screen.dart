import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/widgets/main_nav_button_widget.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentPage = 0;

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
      body: Container(
        child: Stack(
          children: [
            Offstage(
              offstage: _currentPage != 0,
              child: container[0],
            ),
            Offstage(
              offstage: _currentPage != 1,
              child: container[1],
            ),
            Offstage(
              offstage: _currentPage != 2,
              child: container[2],
            ),
            Offstage(
              offstage: _currentPage != 3,
              child: container[3],
            ),
            Offstage(
              offstage: _currentPage != 4,
              child: container[4],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pageSelect(1),
                      child: MainNavButtonWidget(
                          icon: FontAwesomeIcons.magnifyingGlass,
                          label: 'Discover',
                          selected: _currentPage == 1),
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
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(Sizes.size9),
                              ),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.plus,
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
                      ),
                    ),
                  ),
                  // FaIcon(
                  //   FontAwesomeIcons.magnifyingGlass,
                  //   color: Colors.white,
                  // ),
                  // FaIcon(
                  //   FontAwesomeIcons.message,
                  //   color: Colors.white,
                  // ),
                  // FaIcon(
                  //   FontAwesomeIcons.user,
                  //   color: Colors.white,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
