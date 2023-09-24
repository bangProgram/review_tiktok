import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/inbox/chats/models/chats_model.dart';

class ChatsRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> creatChat(ChatsModel chatData) async {
    final ref = await _db.collection('chatroom').add(chatData.toJson());
    await ref.update({'chatId': ref.id});
  }

  Future<Map<String, dynamic>?> getChatroom(String chatId) async {
    final chatData = await _db.collection('chatroom').doc(chatId).get();
    return chatData.data();
  }

  Future<void> updateChatroom(
      {required String chatId, required Map<String, dynamic> chatData}) async {
    await _db.collection('chatroom').doc(chatId).update(chatData);
  }
}

final chatsRepo = Provider((ref) => ChatsRepo());
