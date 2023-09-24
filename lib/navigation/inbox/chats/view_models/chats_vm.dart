import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/account/login/view_models/login_view_model.dart';
import 'package:review_tiktok/navigation/inbox/chats/models/chats_model.dart';
import 'package:review_tiktok/navigation/inbox/chats/repos/chats_repo.dart';
import 'package:review_tiktok/navigation/profile/models/profile_user_model.dart';

class ChatsVM extends AsyncNotifier<ChatsModel> {
  late final ChatsRepo _chatsRepo;
  @override
  FutureOr<ChatsModel> build() {
    print('chats 빌드 시점');
    _chatsRepo = ref.read(chatsRepo);
    return ChatsModel.empty();
  }

  Future<void> creatChat(List<ProfileUserModel> setJoiner) async {
    final user = ref.read(loginVMProvider).value!;
    final title = setJoiner[1].name;
    final titleAvatar = setJoiner[1].avatarURL;
    final joiner = [];
    for (var getJoiner in setJoiner) {
      joiner.add(getJoiner.uid);
    }

    _chatsRepo.creatChat(ChatsModel(
        chatId: "",
        creator: user.uid,
        title: title,
        titleAvatar: titleAvatar,
        recentMsg: "",
        createAt: DateTime.now().millisecondsSinceEpoch,
        changeAt: DateTime.now().millisecondsSinceEpoch,
        joiner: joiner));
  }

  Future<void> getChatroom(String chatId) async {
    state = await AsyncValue.guard(() async {
      final chatData = await _chatsRepo.getChatroom(chatId);
      if (chatData == null) return ChatsModel.empty();
      return ChatsModel.fromJson(chatData);
    });
  }
}

final chatsProvider = AsyncNotifierProvider<ChatsVM, ChatsModel>(
  () => ChatsVM(),
);

final chatsStream = StreamProvider.family.autoDispose<List<ChatsModel>, String>(
  (ref, uid) {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    return db
        .collection('chatroom')
        .where('joiner', arrayContains: uid)
        .orderBy('changeAt', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => ChatsModel.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
  },
);
