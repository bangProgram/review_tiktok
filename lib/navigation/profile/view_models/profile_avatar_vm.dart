import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/navigation/profile/repos/profile_avatar_repo.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_user_vm.dart';

class ProfileAvatarVM extends AsyncNotifier<void> {
  late final ProfileAvatarRepo _profileAvatarRepo;

  @override
  FutureOr<void> build() {
    _profileAvatarRepo = ref.read(profileAvatarRepo);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final uid = ref.read(authRepo).user!.uid;
    final uploadTask = await _profileAvatarRepo.uploadAvatar(uid, file);
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          print("Upload is success");
          state = await AsyncValue.guard(
            () async => await ref
                .read(profileUserProvider.notifier)
                .updateProfile({"hasAvatar": true}),
          );

          break;
      }
    });
  }
}

final profileAvatarProvider = AsyncNotifierProvider<ProfileAvatarVM, void>(
  () => ProfileAvatarVM(),
);
