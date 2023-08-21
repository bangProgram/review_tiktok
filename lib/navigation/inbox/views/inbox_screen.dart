import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/inbox/activity/views/activity_screen.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  void _goActivity(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ActivityScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Inbox',
          style: TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () => _goActivity(context),
            title: const Text(
              'Activity',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: GestureDetector(
              onTap: () => _goActivity(context),
              child: const FaIcon(
                FontAwesomeIcons.chevronRight,
                size: Sizes.size14,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: Sizes.size1,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10,
              horizontal: Sizes.size16,
            ),
            child: const Text(
              'Messages',
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: Sizes.size24,
              backgroundColor: Colors.green.shade400,
              child: const FaIcon(
                FontAwesomeIcons.solidAddressBook,
                color: Colors.white,
              ),
            ),
            title: const Text(
              'Contacts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              'Find your contacts',
              style: TextStyle(
                fontSize: Sizes.size12 + Sizes.size1,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size7,
                horizontal: Sizes.size24,
              ),
              decoration: BoxDecoration(
                color: Colors.red.shade500,
                borderRadius: BorderRadius.circular(
                  Sizes.size5,
                ),
              ),
              child: const Text(
                'Find',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: Sizes.size24,
              backgroundColor: Colors.blue.shade400,
              child: const FaIcon(
                FontAwesomeIcons.solidUser,
                color: Colors.white,
              ),
            ),
            title: const Text(
              'New followers',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              'Messages from followers will appear here',
              style: TextStyle(
                fontSize: Sizes.size12 + Sizes.size1,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
