import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/inbox/chats/models/chats_model.dart';

class ChatsRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> creatChat(ChatsModel chatData) async {
    final ref = await _db.collection('chatroom').add(chatData.toJson());
    await ref.update({'chatId': ref.id});
  }
}

final chatsRepo = Provider((ref) => ChatsRepo());
