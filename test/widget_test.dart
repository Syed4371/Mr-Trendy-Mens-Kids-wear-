import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mr_trendy_mobile/main.dart';

void main() {
  testWidgets('storefront shows disclaimer and cart', (tester) async {
    await tester.pumpWidget(const TrendyApp());
    expect(find.text('MR TRENDY'), findsOneWidget);
    expect(find.textContaining('DEMO ONLY'), findsOneWidget);
    expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
  });
}
