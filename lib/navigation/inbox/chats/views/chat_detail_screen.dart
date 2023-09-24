import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/inbox/chats/view_models/chat_detail_vm.dart';
import 'package:review_tiktok/navigation/inbox/chats/view_models/chats_vm.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const routeName = "chatNext";
  static const routeURL = "";

  final String chatId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _editingController = TextEditingController();

  String _inputText = "";

  void _onTapEmozi() {
    print('이모티콘 클릭클릭!');
  }

  void _focusOut() {
    FocusScope.of(context).unfocus();
  }

  void _writeText(String input) {
    setState(() {
      _inputText = input;
    });
  }

  void _onSubmit(String text) async {
    await ref.read(chatDetailProvider(widget.chatId).notifier).sendMsg(text);
    setState(() {
      _inputText = "";
      _editingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: ref.watch(chatsProvider).when(
              error: (error, stackTrace) => Center(
                child: Text('error : $error'),
              ),
              loading: () => Container(),
              data: (data) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: Sizes.size5,
                  leading: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: Sizes.size20 + Sizes.size2,
                        foregroundImage: data.titleAvatar == ""
                            ? null
                            : NetworkImage(data.titleAvatar),
                        child: data.titleAvatar == "" ? Text(data.title) : null,
                      ),
                      Positioned(
                        right: -Sizes.size3,
                        bottom: -Sizes.size3,
                        child: Container(
                          height: Sizes.size18,
                          width: Sizes.size18,
                          decoration: BoxDecoration(
                              color: Colors.green.shade400,
                              border: Border.all(
                                color: Colors.white,
                                width: Sizes.size3,
                              ),
                              shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                  title: Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Active now',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: Sizes.size12,
                    ),
                  ),
                  trailing: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.flag,
                        color: Colors.black,
                        size: Sizes.size20,
                      ),
                      Gaps.h24,
                      FaIcon(
                        FontAwesomeIcons.ellipsis,
                        color: Colors.black,
                        size: Sizes.size20,
                      )
                    ],
                  ),
                );
              },
            ),
      ),
      body: GestureDetector(
        onTap: _focusOut,
        child: Stack(
          children: [
            ref.watch(chatDetailStream(widget.chatId)).when(
              error: (error, stackTrace) {
                return Center(
                  child: Text(
                    'error : $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              },
              loading: () {
                return Positioned.fill(
                  child: Container(
                    child: const Center(
                      child: Text('test'),
                    ),
                  ),
                );
              },
              data: (data) {
                return ListView.separated(
                  reverse: true,
                  padding: EdgeInsets.only(
                    top: Sizes.size20,
                    right: Sizes.size14,
                    left: Sizes.size14,
                    bottom:
                        MediaQuery.of(context).padding.bottom + Sizes.size72,
                  ),
                  separatorBuilder: (context, index) => Gaps.v10,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final loginUser = ref.read(authRepo).user!;
                    final chatData = data[index];
                    var isMine = loginUser.uid == chatData.senderId;
                    return Row(
                      mainAxisAlignment: isMine
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size12,
                            horizontal: Sizes.size16,
                          ),
                          decoration: BoxDecoration(
                              color: isMine
                                  ? Colors.blue.shade500
                                  : Colors.grey.shade500,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(Sizes.size20),
                                topRight: const Radius.circular(Sizes.size20),
                                bottomRight: Radius.circular(
                                    isMine ? Sizes.size2 : Sizes.size20),
                                bottomLeft: Radius.circular(
                                    isMine ? Sizes.size20 : Sizes.size2),
                              )),
                          child: Text(
                            chatData.text,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                height: Sizes.size64,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size12,
                ),
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: Sizes.size36,
                        child: TextField(
                          controller: _editingController,
                          onChanged: _writeText,
                          onSubmitted: _onSubmit,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: '  Send a message...',
                            hintStyle: const TextStyle(
                              fontSize: Sizes.size16,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _onTapEmozi,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.faceSmile,
                                    color: Colors.black,
                                    size: Sizes.size20,
                                  )
                                ],
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(Sizes.size20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(Sizes.size20),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: Sizes.size10,
                              horizontal: Sizes.size10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gaps.h10,
                    GestureDetector(
                      onTap: () => _onSubmit(_inputText),
                      child: Container(
                        height: Sizes.size32,
                        width: Sizes.size32,
                        decoration: BoxDecoration(
                          color: _inputText.isNotEmpty
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.solidPaperPlane,
                            color: Colors.white,
                            size: Sizes.size14,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
