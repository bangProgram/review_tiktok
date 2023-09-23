import 'dart:async';
import 'dart:io';

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
    final avatarURL = await uploadTask.snapshot.ref.getDownloadURL();
    state = await AsyncValue.guard(
      () async => await ref
          .read(profileUserProvider.notifier)
          .updateProfile({"hasAvatar": true, 'avatarURL': avatarURL}),
    );
  }
}

final profileAvatarProvider = AsyncNotifierProvider<ProfileAvatarVM, void>(
  () => ProfileAvatarVM(),
);
