import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/utils.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _editingController = TextEditingController();

  final List _tabList = [
    'Top',
    'Users',
    'Videos',
    'Sounds',
    'LIVE',
    'Shopping',
    'Health',
    'Sports',
    'News'
  ];

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  void _clearText() {
    _editingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: _tabList.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes.size8,
              ),
            ),
            height: Sizes.size40,
            width: screenWidth * 0.7,
            child: TextField(
              controller: _editingController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gaps.h10,
                    FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: Sizes.size16,
                      color: Colors.black,
                    ),
                  ],
                ),
                suffix: IconButton(
                  splashColor: Colors.transparent,
                  splashRadius: 1,
                  icon: const FaIcon(
                    FontAwesomeIcons.solidCircleXmark,
                    color: Colors.black54,
                    size: Sizes.size16,
                  ),
                  onPressed: _clearText,
                ),
                hintText: 'food tiktok',
                fillColor: Colors.grey.shade600,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                ),
              ),
            ),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            indicatorColor: Colors.black,
            isScrollable: true,
            unselectedLabelColor: Colors.grey.shade600,
            labelColor: isDarkMode(context) ? Colors.white : Colors.black,
            labelStyle: const TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              for (var tab in _tabList) Tab(text: tab),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.size10),
          child: TabBarView(
            children: [
              for (var tabpage in _tabList)
                Container(
                  color: Colors.transparent,
                  child: GridView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 2),
                      mainAxisSpacing: Sizes.size10,
                      crossAxisSpacing: Sizes.size10,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            const AspectRatio(
                              aspectRatio: (1 / 1.5),
                              child: FadeInImage(
                                fit: BoxFit.fill,
                                placeholder:
                                    AssetImage('assets/images/tutorial1.JPG'),
                                image: AssetImage('assets/images/pepe.jpg'),
                              ),
                            ),
                            Gaps.v7,
                            Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              '@${tabpage}_$index : Cajun Chicken Alfredo #foodtiktok #foodfighter #foodtruck ',
                              style: const TextStyle(
                                fontSize: Sizes.size14 + Sizes.size1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gaps.v7,
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: Sizes.size14,
                                  backgroundImage: NetworkImage(
                                    'https://blogpfthumb-phinf.pstatic.net/MjAyMjEyMjNfMTM5/MDAxNjcxNzgwNDg3ODk2.W8-NsFrT3zCfQ05ihG2bvTSoFjuy09UmWiCEmmt2FJog.zlsF-YkJ88u4dXmTP1ofrWUiij4eAlp8mXzvYybAnW0g.JPEG.asdroto/KakaoTalk_20221223_162730416.jpg/KakaoTalk_20221223_162730416.jpg',
                                  ),
                                ),
                                Gaps.h5,
                                Expanded(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    'Burnt_Pellet wjsquddnr dhffladlek dlwktlrdk',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: Sizes.size14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                FaIcon(
                                  FontAwesomeIcons.heart,
                                  size: Sizes.size12,
                                  color: Colors.grey.shade500,
                                ),
                                Gaps.h5,
                                Text(
                                  '2.0M',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: Sizes.size12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
