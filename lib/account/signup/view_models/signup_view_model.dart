import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/account/interests/views/interest_screen.dart';
import 'package:review_tiktok/account/login/view_models/login_view_model.dart';
import 'package:review_tiktok/account/signup/repos/signup_repo.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/common/notification/notification_service.dart';
import 'package:review_tiktok/navigation/profile/models/profile_user_model.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_user_vm.dart';
import 'package:review_tiktok/utils.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepo _authRepo;
  late final SignupRepo _signupRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
    _signupRepo = ref.read(signupRepo);
  }

  Future<void> userSignup(BuildContext context) async {
    state = const AsyncValue.loading();
    final user = ref.read(signupState);
    ProfileUserModel userData = ProfileUserModel.empty();
    state = await AsyncValue.guard(() async {
      final credential = await _authRepo.userSignup(
        user['email'],
        user['password'],
      );

      if (credential.user != null) {
        final uId = credential.user!.uid;
        print('Signup Repo uId : $uId');
        userData = ProfileUserModel(
            uid: uId,
            name: user['name'],
            email: user['email'],
            birthday: user['birthday'],
            bio: '',
            link: '',
            avatarURL: '',
            token: '',
            hasAvatar: false);
        await _signupRepo.signupUserByMap(uId, userData);
      }
    });
    if (state.hasError) {
      await _authRepo.userDelete();
      await _authRepo.userLogout();
      showFirebaseError(context, state.error);
    } else {
      ref.read(loginVMProvider.notifier).state = AsyncValue.data(userData);
      context.goNamed(InterestScreen.routeName);
    }
  }

  Future<void> githubSignup(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _authRepo.githubLogin());
    if (state.hasError) {
      showFirebaseError(context, state.error);
    } else {
      context.goNamed(InterestScreen.routeName);
    }
  }
}

final signupState = StateProvider((ref) => {});

final signupVMProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
