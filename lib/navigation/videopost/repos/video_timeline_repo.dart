import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoTimelineRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideo({int? creatAt}) async {
    if (creatAt == null) {
      return await _db
          .collection('videos')
          .limit(2)
          .orderBy('creatAt', descending: true)
          .get();
    } else {
      return await _db
          .collection('videos')
          .limit(2)
          .orderBy('creatAt', descending: true)
          .startAfter([creatAt]).get();
    }
  }

  Future<void> toggleLikeVideo({
    required String videoId,
    required List liker,
  }) async {
    await _db.collection('videos').doc(videoId).update({'liker': liker});
  }
}

final videoTimelineRepo = Provider((ref) => VideoTimelineRepo());
