import 'package:go_router/go_router.dart';
import 'package:review_tiktok/account/interests/views/interest_screen.dart';
import 'package:review_tiktok/account/views/login_screen.dart';
import 'package:review_tiktok/account/views/signup_screen.dart';
import 'package:review_tiktok/navigation/inbox/activity/views/activity_screen.dart';
import 'package:review_tiktok/navigation/inbox/chats/views/chats_screen.dart';
import 'package:review_tiktok/navigation/views/main_nav_screen.dart';

final router = GoRouter(
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
    ),
  ],
);
