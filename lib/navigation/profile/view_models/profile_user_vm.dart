import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      final uid = _authenticationRepo.user!.uid;
      print('JB 확인 : $uid');
      final user = await _profileUserRepo.findUser(uid);
      print('JB 확인 : $user');
      if (user != null) {
        print('JB 확인 : ${ProfileUserModel.fromJson(user)}');
        return ProfileUserModel.fromJson(user);
      }
    }
    return ProfileUserModel.empty();
  }

  Future<void> createUser(
      UserCredential credential, Map<dynamic, dynamic> data) async {
    if (credential.user == null) {
      throw Exception('credential Error');
    }
    state = const AsyncValue.loading();
    final uid = credential.user!.uid;
    print('JB 확인 : ${data.runtimeType}');
    final profile = ProfileUserModel(
        uid: uid,
        name: data["name"],
        email: data["email"],
        birthday: data["birthday"],
        bio: "bio",
        link: "link");
    print('JB 확인 : $profile');
    await _profileUserRepo.createUser(uid, profile);
    state = AsyncValue.data(profile);
  }

  Future<Map<String, dynamic>?> findUser() async {
    state = const AsyncValue.loading();
    final uid = _authenticationRepo.user!.uid;
    return _profileUserRepo.findUser(uid);
  }
}

final profileUserProvider =
    AsyncNotifierProvider<ProfileUserVM, ProfileUserModel>(
  () => ProfileUserVM(),
);
