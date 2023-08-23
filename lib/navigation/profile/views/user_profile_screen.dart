import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: const Text(
            'JunBang',
            style: TextStyle(
              fontSize: Sizes.size18,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.gear,
                color: Colors.black,
                size: Sizes.size18,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const CircleAvatar(
                radius: Sizes.size40,
                foregroundImage: AssetImage("assets/images/Acrid2.jpg"),
                child: Text('Junbang'),
              ),
              Gaps.v10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '@Junbang_Crid',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.h10,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: Colors.blue.shade400,
                    size: Sizes.size14,
                  ),
                ],
              ),
              Gaps.v16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const UserInfoWidget(title: '37', subtitle: 'Following'),
                  SizedBox(
                    height: Sizes.size20,
                    child: VerticalDivider(
                      color: Colors.grey.shade400,
                      width: Sizes.size36,
                      thickness: Sizes.size1,
                    ),
                  ),
                  const UserInfoWidget(title: '10.5M', subtitle: 'Followers'),
                  SizedBox(
                    height: Sizes.size20,
                    child: VerticalDivider(
                      color: Colors.grey.shade400,
                      width: Sizes.size36,
                      thickness: Sizes.size1,
                    ),
                  ),
                  const UserInfoWidget(title: '149.3M', subtitle: 'Likes'),
                ],
              )
            ],
          ),
        )
      ],
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
        )
      ],
    );
  }
}
