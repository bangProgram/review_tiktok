import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:review_tiktok/firebase_options.dart';
import 'package:review_tiktok/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseAuth.instance.signOut();
  });

  testWidgets("Create Account Flow", (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text("Sign up for TikTok"), findsOneWidget);
    final loginBtn = find.text("Log in");
    expect(loginBtn, findsOneWidget);
    await tester.tap(loginBtn);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text("Log in to TikTok"), findsOneWidget);
    final signupBtn = find.text("Sign up");
    expect(signupBtn, findsOneWidget);
    await tester.tap(signupBtn);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text("Sign up for TikTok"), findsOneWidget);
    final emailSignupBtn = find.text("Create with your email");
    expect(emailSignupBtn, findsOneWidget);
    await tester.tap(emailSignupBtn);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text("Create username"), findsOneWidget);
    final nameField = find.byType(TextField).first;
    expect(nameField, findsOneWidget);
    await tester.enterText(nameField, "jbw2023");
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));
    final nextBtn = find.text("Go Next");
    expect(nextBtn, findsOneWidget);
    await tester.tap(nextBtn);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text("Create with your Email"), findsOneWidget);
    final emailField = find.byType(TextField).first;
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, "zxc@naver.com");
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(nextBtn, findsOneWidget);
    await tester.tap(nextBtn);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text("Create password"), findsOneWidget);
    final passField = find.byType(TextField).first;
    expect(passField, findsOneWidget);
    await tester.enterText(passField, "qweqweqwe");
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(nextBtn, findsOneWidget);
    await tester.tap(nextBtn);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text("When's your birthday?"), findsOneWidget);
    expect(nextBtn, findsOneWidget);
    await tester.tap(nextBtn);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text("Choose Your interests"), findsOneWidget);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
