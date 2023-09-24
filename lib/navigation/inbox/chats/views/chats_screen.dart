import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/inbox/chats/models/chats_model.dart';
import 'package:review_tiktok/navigation/inbox/chats/view_models/chats_vm.dart';
import 'package:review_tiktok/navigation/inbox/chats/views/chat_detail_screen.dart';
import 'package:review_tiktok/navigation/inbox/chats/views/chat_user_screen.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  static const routeName = "chat";
  static const routeURL = "/chat";
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  void _addDirectMessage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChatUserScreen(),
      ),
    );
  }

  void _delDirectMessage(int index) {}

  Future<void> _goChatDetail(ChatsModel chatroom) async {
    print('chats 호출전');
    await ref.read(chatsProvider.notifier).getChatroom(chatroom.chatId);
    print('chats 호출후');
    context.pushNamed(
      ChatDetailScreen.routeName,
      pathParameters: {
        "chatId": chatroom.chatId,
      },
    );
  }

  Widget _makeDirectMessage(ChatsModel chatroom) {
    final time = DateTime.fromMillisecondsSinceEpoch(chatroom.changeAt);
    print('time : $time');
    return ListTile(
      leading: CircleAvatar(
        radius: Sizes.size28,
        backgroundColor: Colors.blue,
        foregroundImage: chatroom.titleAvatar != ""
            ? NetworkImage(chatroom.titleAvatar)
            : null,
        child: chatroom.titleAvatar != "" ? null : Text(chatroom.title),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            chatroom.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${time.hour}:${time.minute}',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      subtitle: Text(
        chatroom.recentMsg,
        style: const TextStyle(
          fontSize: Sizes.size14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authRepo).user!;
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
      body: ref.watch(chatsStream(user.uid)).when(
            error: (error, stackTrace) {
              return Center(
                child: Text('Error : $error'),
              );
            },
            loading: () => const CircularProgressIndicator(),
            data: (data) => ListView.separated(
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final chatroom = data[index];
                return Column(
                  children: [
                    GestureDetector(
                      onLongPress: () => _delDirectMessage(index),
                      onTap: () => _goChatDetail(chatroom),
                      child: _makeDirectMessage(chatroom),
                    ),
                    Gaps.v2,
                  ],
                );
              },
            ),
          ),
    );
  }
}
