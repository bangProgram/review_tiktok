import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/account/interests/views/interest_screen.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_user_vm.dart';
import 'package:review_tiktok/utils.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepo _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> userSignup(BuildContext context) async {
    state = const AsyncValue.loading();
    final user = ref.read(signupState);
    state = await AsyncValue.guard(() async {
      final credential = await _authRepo.userSignup(
        user['email'],
        user['password'],
      );
      await ref.read(profileUserProvider.notifier).createUser(credential, user);
    });
    if (state.hasError) {
      showFirebaseError(context, state.error);
    } else {
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
