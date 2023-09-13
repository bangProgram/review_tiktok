import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/account/views/signup_screen.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/navigation/views/main_nav_screen.dart';
import 'package:review_tiktok/utils.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepo _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> userLogout(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _authRepo.userLogout());
    if (state.hasError) {
      showFirebaseError(context, state.error);
    } else {
      context.goNamed(SignupScreen.routeName);
    }
  }

  Future<void> userLogin(
      BuildContext context, Map<String, String> userData) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        await _authRepo.userLogin(userData['email']!, userData['password']!);
      },
    );
    if (state.hasError) {
      showFirebaseError(context, state.error);
    } else {
      context.go(MainNavScreen.routeURL);
    }
  }

  Future<void> githubLogin(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _authRepo.githubLogin());
    if (state.hasError) {
      showFirebaseError(context, state.error);
    } else {
      context.go(MainNavScreen.routeURL);
    }
  }
}

final loginVMProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
