import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/account/login/view_models/login_view_model.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/navigation/profile/models/profile_user_model.dart';
import 'package:review_tiktok/navigation/profile/repos/profile_user_repo.dart';

class ProfileUserVM extends AsyncNotifier<ProfileUserModel> {
  late final AuthenticationRepo _authenticationRepo;
  late final ProfileUserRepo _profileUserRepo;

  @override
  FutureOr<ProfileUserModel> build() async {
    _authenticationRepo = ref.read(authRepo);
    _profileUserRepo = ref.read(profileUserRepo);
    if (_authenticationRepo.isLogin) {
      final user = ref.read(loginVMProvider).value;
      print('ProfileUserVM : $user');
      if (user != null) {
        state = AsyncValue.data(user);
        return user;
      }
    }
    print('ProfileUserVM init Data');
    state = AsyncValue.data(ProfileUserModel.empty());
    return ProfileUserModel.empty();
  }

  Future<void> createUser(
      UserCredential credential, Map<String, dynamic> data) async {
    if (credential.user == null) {
      throw Exception('credential Error');
    }
    state = const AsyncValue.loading();
    final uid = credential.user!.uid;
    final profile = state.value!.copyWith(data);
    await _profileUserRepo.createUser(uid, profile);
    state = AsyncValue.data(profile);
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    final uid = ref.read(authRepo).user!.uid;
    final profile = state.value!.copyWith(data);
    await _profileUserRepo.updateUser(uid, profile);
    state = AsyncValue.data(profile);
    ref.read(loginVMProvider.notifier).state = state;
  }

  Future<ProfileUserModel> findProfile(String uid) async {
    final user = await _profileUserRepo.findProfile(uid);
    if (user != null) {
      final userModel = ProfileUserModel.fromJson(user);
      state = AsyncValue.data(userModel);
      return userModel;
    } else {
      throw Exception('사용자를 찾지못했습니다.');
    }
  }

  Future<List<ProfileUserModel>> findProfileList() async {
    final user = ref.read(authRepo).user!;
    final snapshot = await _profileUserRepo.findProfileList(user.uid);
    return snapshot.docs
        .map((e) => ProfileUserModel.fromJson(e.data()))
        .toList();
  }

  Future<void> reloadProfileByModel(ProfileUserModel user) async {
    state = AsyncValue.data(user);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final uid = ref.read(authRepo).user!.uid;
    final uploadTask = await _profileUserRepo.uploadAvatar(uid, file);
    if (uploadTask.metadata != null) {
      final avatarURL = await uploadTask.ref.getDownloadURL();
      final ProfileUserModel userData =
          state.value!.copyWith({"hasAvatar": true, 'avatarURL': avatarURL});
      state = AsyncValue.data(userData);
    }
  }
}

final profileUserProvider =
    AsyncNotifierProvider<ProfileUserVM, ProfileUserModel>(
  () => ProfileUserVM(),
);
