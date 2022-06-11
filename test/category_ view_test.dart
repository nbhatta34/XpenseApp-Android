import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpense_android/Screens/AddCategory.dart';

void main() {
  testWidgets('category page', (tester) async {
    final CategoryName = find.byKey(ValueKey("Category Name"));

    final button = find.byKey(ValueKey('ADD CATEGORY'));
    //
    await tester
        .pumpWidget(ProviderScope(child: MaterialApp(home: AddCategory())));
    await tester.enterText(CategoryName, "PC");

    await tester.tap(button);
    await tester.pump();
    //
    expect(find.text('PC'), findsOneWidget);
  });
}
