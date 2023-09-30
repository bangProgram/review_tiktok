import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:review_tiktok/account/signup/widgets/nextpage_button_widget.dart';

void main() {
  group("From button tests", () {
    testWidgets("Invalid state form button", (WidgetTester tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: NextPageButtonWidget(
                funtcion: () {}, text: 'Next', valid: false),
          ),
        ),
      );

      expect(find.text("Next"), findsOneWidget);
      expect(tester.firstWidget<Text>(find.byType(Text)).style!.color,
          Colors.black);
    });

    testWidgets("Valid state form button", (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child:
              NextPageButtonWidget(funtcion: () {}, text: 'Next', valid: true),
        ),
      );

      expect(find.text("Next"), findsOneWidget);
      expect(tester.firstWidget<Text>(find.byType(Text)).style!.color,
          Colors.white);
    });

    testWidgets("Invalid State Darkmode", (WidgetTester tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(platformBrightness: Brightness.dark),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: NextPageButtonWidget(
                funtcion: () {}, text: 'Next', valid: false),
          ),
        ),
      );

      expect(tester.firstWidget<Text>(find.byType(Text)).style!.color,
          Colors.black);
    });
  });
}
