import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbit_trucker_2d/main.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: OrbitTruckerApp()));

    // Allow any initial animations or loaders to settle
    await tester.pump();

    // Verify that we have a game widget (or just that we reached this point)
    expect(find.byType(OrbitTruckerApp), findsOneWidget);
  });
}
