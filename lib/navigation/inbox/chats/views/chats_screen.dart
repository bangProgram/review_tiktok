import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _globalKey =
      GlobalKey<AnimatedListState>();

  final List<int> _dmList = [];

  void _addDirectMessage() {
    if (_globalKey.currentState != null) {
      _globalKey.currentState!.insertItem(_dmList.length);
    }
    _dmList.add(_dmList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text(
          'Direct Messages',
          style: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _addDirectMessage,
            icon: const FaIcon(
              FontAwesomeIcons.plus,
            ),
          ),
        ],
      ),
      body: AnimatedList(
        key: _globalKey,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        itemBuilder: (context, index, animation) {
          return Column(
            children: [
              FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: Sizes.size28,
                      backgroundColor: Colors.blue,
                      child: Text('전뱅'),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Junbang',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '2:16 PM',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: Sizes.size14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    subtitle: const Text(
                      'junbang아 집에가서 도시락 먹어라 살빼야지???',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                      ),
                    ),
                  ),
                ),
              ),
              Gaps.v2,
            ],
          );
        },
      ),
    );
  }
}
