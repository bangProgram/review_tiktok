import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/account/login/view_models/login_view_model.dart';
import 'package:review_tiktok/navigation/inbox/chats/models/chat_detail_model.dart';
import 'package:review_tiktok/navigation/inbox/chats/repos/chat_detail_repo.dart';
import 'package:review_tiktok/navigation/inbox/chats/repos/chats_repo.dart';

class ChatDetailVM extends FamilyAsyncNotifier<void, String> {
  late final ChatDetailRepo _chatDetailRepo;
  late final ChatsRepo _chatsRepo;
  late final String chatId;

  @override
  FutureOr<void> build(String arg) {
    _chatDetailRepo = ref.read(chatDetailRepo);
    _chatsRepo = ref.read(chatsRepo);
    chatId = arg;
  }

  Future<void> sendMsg(String text) async {
    final user = ref.read(loginVMProvider).value!;
    final msgData = ChatDetailModel(
      text: text,
      senderId: user.uid,
      senderNm: user.name,
      likes: [],
      createAt: DateTime.now().millisecondsSinceEpoch,
      deleteAt: 0,
    );
    await _chatDetailRepo.sendMsg(chatId: chatId, msgData: msgData);

    await _chatsRepo.updateChatroom(chatId: chatId, chatData: {
      'recentMsg': text,
      'changeAt': DateTime.now().millisecondsSinceEpoch
    });
  }
}

final chatDetailProvider =
    AsyncNotifierProvider.family<ChatDetailVM, void, String>(
  () => ChatDetailVM(),
);

final chatDetailStream = StreamProvider.family
    .autoDispose<List<ChatDetailModel>, String>((ref, chatId) {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  return db
      .collection('chatroom')
      .doc(chatId)
      .collection('chats')
      .orderBy('createAt', descending: true)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (e) => ChatDetailModel.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );
});
