import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/inbox/chats/models/chat_detail_model.dart';

class ChatDetailRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMsg(
      {required String chatId, required ChatDetailModel msgData}) async {
    await _db
        .collection('chatroom')
        .doc(chatId)
        .collection('chats')
        .add(msgData.toJson());
  }
}

final chatDetailRepo = Provider((ref) => ChatDetailRepo());
