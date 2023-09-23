import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/account/login/view_models/login_view_model.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/navigation/inbox/chats/view_models/chats_vm.dart';
import 'package:review_tiktok/navigation/profile/models/profile_user_model.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_user_vm.dart';

class ChatUserScreen extends ConsumerStatefulWidget {
  static const routeName = "chatNext";
  static const routeURL = "";

  const ChatUserScreen({super.key});

  @override
  ConsumerState<ChatUserScreen> createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends ConsumerState<ChatUserScreen> {
  List<ProfileUserModel> setJoiner = [];
  List<String> chkJoiner = [];
  late final ProfileUserModel loginUser;

  @override
  void initState() {
    super.initState();
    loginUser = ref.read(loginVMProvider).value!;
    setJoiner.add(loginUser);
    chkJoiner.add(loginUser.uid);
  }

  void joinerSelect(ProfileUserModel userModel) {
    if (chkJoiner.contains(userModel.uid)) {
      final index = chkJoiner.indexOf(userModel.uid);
      setJoiner.removeAt(index);
      chkJoiner.remove(userModel.uid);
    } else {
      setJoiner.add(userModel);
      chkJoiner.add(userModel.uid);
    }
    setState(() {});
  }

  void creatChat() async {
    await ref.read(chatProvider.notifier).creatChat(setJoiner);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('대화방 초대'),
        actions: [
          TextButton(
            onPressed: creatChat,
            child: const Text('확인'),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '대화상대 검색',
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Sizes.size20, vertical: Sizes.size10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      Sizes.size36,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: ref.read(profileUserProvider.notifier).findProfileList(),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data != null) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Gaps.v14,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final userModel = data[index];
                    return ListTile(
                      leading: CircleAvatar(
                        foregroundImage: userModel.hasAvatar
                            ? NetworkImage(userModel.avatarURL)
                            : null,
                        child:
                            userModel.hasAvatar ? null : Text(userModel.name),
                      ),
                      title: Text(userModel.name),
                      trailing: Checkbox(
                          shape: const CircleBorder(),
                          value: chkJoiner.contains(userModel.uid),
                          onChanged: (value) => joinerSelect(userModel)),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          )),
        ],
      ),
    );
  }
}
