import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myhomepage/widgets/decorated_page_title.dart';

void main() {
  testWidgets('DecoratedPageTitle displays title with layer decorations',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DecoratedPageTitle(title: '作品'),
        ),
      ),
    );

    // 影、外枠、内枠、文字本体の4層で描画されていることを確認
    expect(find.text('作品'), findsNWidgets(4));
  });
}
