import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_user_vm.dart';
import 'package:review_tiktok/navigation/profile/views/user_edit_screen.dart';
import 'package:review_tiktok/navigation/profile/views/user_setting_screen.dart';
import 'package:review_tiktok/navigation/profile/widgets/sliver_haeder_tabbar.dart';
import 'package:review_tiktok/utils.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _goSetting() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UserSettingScreen(),
      ),
    );
  }

  void _goUserEditScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UserEditScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(profileUserProvider).when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) {
            return Center(
              child: Text('Error Occured : $error'),
            );
          },
          data: (data) => SafeArea(
            child: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      centerTitle: true,
                      title: Text(
                        data.email,
                        style: const TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      actions: [
                        Container(
                          width: MediaQuery.of(context).size.width / 4.5,
                          padding: const EdgeInsets.only(right: Sizes.size10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: _goUserEditScreen,
                                  child: Container(
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: FaIcon(
                                      FontAwesomeIcons.userPen,
                                      color: isDarkMode(context)
                                          ? null
                                          : Colors.black,
                                      size: Sizes.size18,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: _goSetting,
                                  child: Container(
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: FaIcon(
                                      FontAwesomeIcons.gear,
                                      color: isDarkMode(context)
                                          ? null
                                          : Colors.black,
                                      size: Sizes.size18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Gaps.v14,
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.red.shade300,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: Sizes.size40,
                              foregroundImage: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/jb-review-tiktok-clone.appspot.com/o/users%2F${data.uid}?alt=media&token=9878200a-835b-4268-88dc-939b011fe013'),
                              child: const Text('Junbang'),
                            ),
                          ),
                          Gaps.v10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '@${data.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gaps.h10,
                              FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                color: Colors.lightBlue.shade200,
                                size: Sizes.size14,
                              ),
                            ],
                          ),
                          Gaps.v16,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const UserInfoWidget(
                                  title: '37', subtitle: 'Following'),
                              SizedBox(
                                height: Sizes.size20,
                                child: VerticalDivider(
                                  color: Colors.grey.shade400,
                                  width: Sizes.size36,
                                  thickness: Sizes.size1,
                                ),
                              ),
                              const UserInfoWidget(
                                  title: '10.5M', subtitle: 'Followers'),
                              SizedBox(
                                height: Sizes.size20,
                                child: VerticalDivider(
                                  color: Colors.grey.shade400,
                                  width: Sizes.size36,
                                  thickness: Sizes.size1,
                                ),
                              ),
                              const UserInfoWidget(
                                  title: '149.3M', subtitle: 'Likes'),
                            ],
                          ),
                          Gaps.v14,
                          FractionallySizedBox(
                            widthFactor: 0.33,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size12,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(Sizes.size4),
                                ),
                              ),
                              child: const Text(
                                'Follow',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Gaps.v14,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size10,
                            ),
                            child: Text(
                              data.bio,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Gaps.v5,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(Sizes.size4),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade400,
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size5),
                                ),
                                child: const Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.arrowDown,
                                    color: Colors.white,
                                    size: Sizes.size10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gaps.v14,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.link,
                                size: Sizes.size12,
                              ),
                              Gaps.h4,
                              Text(
                                data.link,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Gaps.v14,
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: SliverHeaderTabbar(),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1 / 1.4,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            const AspectRatio(
                              aspectRatio: 1 / 1.4,
                              child: FadeInImage(
                                fit: BoxFit.cover,
                                placeholder:
                                    AssetImage('assets/images/Acrid1.jpg'),
                                image: AssetImage('assets/images/pepe.jpg'),
                              ),
                            ),
                            Positioned(
                              bottom: Sizes.size5,
                              left: Sizes.size5,
                              child: Row(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.play,
                                    color: Colors.white,
                                    size: Sizes.size14,
                                  ),
                                  Gaps.h8,
                                  Text(
                                    '${index + 1}M',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: Sizes.size12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Container(
                      color: Colors.amber,
                      child: const Center(
                        child: Text('screen 2'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}

class UserInfoWidget extends StatelessWidget {
  final String title, subtitle;

  const UserInfoWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w800,
          ),
        ),
        Gaps.v3,
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: Sizes.size12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
