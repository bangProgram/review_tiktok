import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/account/interests/views/interest_screen.dart';
import 'package:review_tiktok/account/views/login_screen.dart';
import 'package:review_tiktok/account/views/signup_screen.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/common/notification/notification_service.dart';
import 'package:review_tiktok/navigation/inbox/activity/views/activity_screen.dart';
import 'package:review_tiktok/navigation/inbox/chats/views/chat_detail_screen.dart';
import 'package:review_tiktok/navigation/inbox/chats/views/chats_screen.dart';
import 'package:review_tiktok/navigation/videorecord/views/video_recode_screen.dart';
import 'package:review_tiktok/navigation/views/main_nav_screen.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
        initialLocation: "/inbox",
        redirect: (context, state) {
          final isLogin = ref.watch(authRepo).isLogin;
          final user = ref.watch(authRepo).user;
          print('Router : Login 유무 확인 : $isLogin');
          if (!isLogin) {
            if (state.uri.toString() != SignupScreen.routeURL &&
                state.uri.toString() != LoginScreen.routeURL) {
              return SignupScreen.routeURL;
            }
          }
          return null;
        },
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              ref.read(notificationProvider(context));
              return child;
            },
            routes: [
              GoRoute(
                name: SignupScreen.routeName,
                path: SignupScreen.routeURL,
                builder: (context, state) => const SignupScreen(),
              ),
              GoRoute(
                name: LoginScreen.routeName,
                path: LoginScreen.routeURL,
                builder: (context, state) => const LoginScreen(),
              ),
              GoRoute(
                name: InterestScreen.routeName,
                path: InterestScreen.routeURL,
                builder: (context, state) => const InterestScreen(),
              ),
              GoRoute(
                path: "/:tab(home|discover|inbox|profile)",
                name: MainNavScreen.routeName,
                builder: (context, state) {
                  final tab = state.pathParameters['tab']!;
                  return MainNavScreen(tab: tab);
                },
              ),
              GoRoute(
                path: ActivityScreen.routeURL,
                name: ActivityScreen.routeName,
                builder: (context, state) => const ActivityScreen(),
              ),
              GoRoute(
                path: ChatsScreen.routeURL,
                name: ChatsScreen.routeName,
                builder: (context, state) => const ChatsScreen(),
                routes: [
                  GoRoute(
                    path: ":chatId",
                    name: ChatDetailScreen.routeName,
                    builder: (context, state) {
                      final chatId = state.pathParameters['chatId']!;
                      return ChatDetailScreen(chatId: chatId);
                    },
                  ),
                ],
              ),
              GoRoute(
                path: VideoRecordScreen.routeURL,
                name: VideoRecordScreen.routeName,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    transitionDuration: const Duration(seconds: 1),
                    child: const VideoRecordScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final slideAnimation = Tween(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(animation);
                      return SlideTransition(
                        position: slideAnimation,
                        child: child,
                      );
                    },
                  );
                },
              )
            ],
          )
        ]);
  },
);
