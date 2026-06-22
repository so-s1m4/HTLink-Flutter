// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:htlink/app.dart';

void main() {
  testWidgets('App opens home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text('Hello World'), findsWidgets);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();

    expect(find.text('My Profile'), findsOneWidget);
  });
}
