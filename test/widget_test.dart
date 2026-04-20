import 'package:ehky_chat_app/route.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app loads splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(EhkyApp());

    expect(find.text('Ehky'), findsOneWidget);
  });
}
