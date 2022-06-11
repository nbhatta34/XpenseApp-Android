
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:xpense_android/Screens/AddClientInformation.dart';


void main() {
  testWidgets("Testing the widget",
      (WidgetTester tester) async {


    final AddClientInfo = find.byType(Scaffold);

    expect(AddClientInfo, findsOneWidget);
});
}