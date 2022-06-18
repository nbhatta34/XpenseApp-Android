import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xpense_android/Screens/Statistics.dart';

void main() {
  testWidgets("Flutter Widget Test", (WidgetTester tester) async {
    await tester.pumpWidget(Scaffold());

    final SfCircularChart = find.byType(Scaffold);
    expect(SfCircularChart, findsOneWidget);
  });
}
