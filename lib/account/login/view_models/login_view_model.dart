import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/account/views/signup_screen.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/common/notification/notification_service.dart';
import 'package:review_tiktok/navigation/profile/models/profile_user_model.dart';
import 'package:review_tiktok/navigation/profile/repos/profile_user_repo.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_user_vm.dart';
import 'package:review_tiktok/navigation/views/main_nav_screen.dart';
import 'package:review_tiktok/utils.dart';

class LoginViewModel extends AsyncNotifier<ProfileUserModel> {
  late final AuthenticationRepo _authRepo;
  late final ProfileUserRepo _profileUserRepo;

  @override
  FutureOr<ProfileUserModel> build() async {
    _authRepo = ref.read(authRepo);
    _profileUserRepo = ref.read(profileUserRepo);
    if (_authRepo.isLogin) {
      final uid = _authRepo.user!.uid;
      final user = await _profileUserRepo.findProfile(uid);
      print('login User : $user');
      if (user != null) {
        return ProfileUserModel.fromJson(user);
      }
    }
    return ProfileUserModel.empty();
  }

  Future<void> userLogout(BuildContext context) async {
    await _authRepo.userLogout();
    state = AsyncValue.data(ProfileUserModel.empty());
    context.goNamed(SignupScreen.routeName);
  }

  Future<void> userLogin(
      BuildContext context, Map<String, String> userData) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        final credential = await _authRepo.userLogin(
            userData['email']!, userData['password']!);
        final userModel = await ref
            .read(profileUserProvider.notifier)
            .findProfile(credential.user!.uid);
        return userModel;
      },
    );
    await ref
        .read(notificationProvider(context).notifier)
        .updateToken(token: null);
    if (state.hasError) {
      showFirebaseError(context, state.error);
    } else {
      context.go(MainNavScreen.routeURL);
    }
  }

  Future<void> githubLogin(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final credential = await _authRepo.githubLogin();
      final userModel = await ref
          .read(profileUserProvider.notifier)
          .findProfile(credential.user!.uid);
      return userModel;
    });
    if (state.hasError) {
      showFirebaseError(context, state.error);
    } else {
      context.go(MainNavScreen.routeURL);
    }
  }
}

final loginVMProvider = AsyncNotifierProvider<LoginViewModel, ProfileUserModel>(
  () => LoginViewModel(),
);
