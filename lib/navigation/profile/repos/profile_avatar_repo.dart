import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileAvatarRepo {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UploadTask> uploadAvatar(String uid, File file) async {
    final task = _storage.ref().child('users/$uid').putFile(file);
    return task;
  }
}

final profileAvatarRepo = Provider((ref) => ProfileAvatarRepo());
