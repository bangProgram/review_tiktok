import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/profile/models/profile_user_model.dart';

class SignupRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> signupUserByMap(String userId, ProfileUserModel data) async {
    await _db.collection('users').doc(userId).set(data.tojson());
  }
}

final signupRepo = Provider((ref) => SignupRepo());
