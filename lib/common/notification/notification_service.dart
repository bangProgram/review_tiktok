import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/navigation/profile/repos/profile_user_repo.dart';

class NotificationService extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late final ProfileUserRepo _profileUserRepo;

  @override
  FutureOr<void> build(BuildContext context) async {
    print('token init');

    await updateToken();
    await initListener(context);
    _messaging.onTokenRefresh.listen((newToken) async {
      updateToken(token: newToken);
    });

    state = const AsyncValue.data('');
  }

  Future<void> updateToken({String? token}) async {
    String? newToken = "";

    if (token == null) {
      newToken = await _messaging.getToken();
    }

    _profileUserRepo = ref.read(profileUserRepo);
    final auth = ref.read(authRepo);
    print('token setup');
    if (auth.isLogin) {
      final user = auth.user!;
      print('token setup user : ${user.email}');
      await _profileUserRepo.updateProfileByJson(
        user.uid,
        {'token': token ?? newToken},
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
}

final notificationProvider =
    AsyncNotifierProvider.family<NotificationService, void, BuildContext>(
  () => NotificationService(),
);
