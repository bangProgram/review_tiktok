import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/account/login/view_models/login_view_model.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/navigation/profile/repos/profile_user_repo.dart';

class NotificationService extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late final ProfileUserRepo _profileUserRepo;

  @override
  FutureOr<void> build(BuildContext context) async {
    print('token init');
    await initListener(context);
    _messaging.onTokenRefresh.listen((newToken) async {
      updateToken(token: newToken);
    });
  }

  Future<void> updateToken({String? token}) async {
    String? newToken = "";

    if (token == null) {
      newToken = await _messaging.getToken();
    }

    _profileUserRepo = ref.read(profileUserRepo);
    final isLogin = ref.read(authRepo).isLogin;
    print('token setup');
    if (isLogin) {
      final loginUser = ref.read(loginVMProvider).value!;
      print('token setup user : ${loginUser.email}');
      await _profileUserRepo.updateUser(
        loginUser.uid,
        loginUser.copyWith(
          {'token': token ?? newToken},
        ),
      );
    }
  }

  Future<void> initListener(BuildContext context) async {
    final permission = await _messaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground! Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Foreground!  Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Background! Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Background! Message also contained a notification: ${message.notification}');
      }
    });

    final message = await _messaging.getInitialMessage();
    if (message != null) {
      print('Disconnected! Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Disconnected! Message also contained a notification: ${message.notification}');
      }
    }
  }

  Future<void> setupInteractedMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  void handleMessage(RemoteMessage message) {}
}

final notificationProvider =
    AsyncNotifierProvider.family<NotificationService, void, BuildContext>(
  () => NotificationService(),
);
