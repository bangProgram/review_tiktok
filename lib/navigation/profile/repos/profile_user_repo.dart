import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/profile/models/profile_user_model.dart';

class ProfileUserRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createUser(String uid, ProfileUserModel data) async {
    await _db.collection('users').doc(uid).set(data.tojson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data();
  }

  Future<void> updateUser(String uid, ProfileUserModel data) async {
    await _db.collection('users').doc(uid).update(data.tojson());
  }

  Future<void> updateProfileByJson(
      String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> findProfileList(
      String uid) async {
    return await _db.collection('users').where('uid', isNotEqualTo: uid).get();
  }

  Future<TaskSnapshot> uploadAvatar(String uid, File file) async {
    print('uploadAvatar : $uid / ${file.path}');
    final task = await _storage.ref().child('users/$uid').putFile(file);
    return task;
  }
}

final profileUserRepo = Provider((ref) => ProfileUserRepo());
