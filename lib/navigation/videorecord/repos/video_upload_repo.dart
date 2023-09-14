import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/videorecord/models/video_model.dart';

class VideoUploadRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UploadTask> uploadVideoStorage(String uid, File file) async {
    final ref = _storage
        .ref()
        .child('videos/$uid/${DateTime.now().millisecondsSinceEpoch}');
    return ref.putFile(file);
  }

  Future<void> uploadVideoDB(VideoModel data) async {
    await _db.collection('videos').add(data.toJson());
  }
}

final videoUploadRepo = Provider((ref) => VideoUploadRepo());
