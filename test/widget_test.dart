import 'package:flutter_test/flutter_test.dart';
import 'package:genmobi_studio/app.dart';

void main() {
  testWidgets('App title smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('GenMobi Studio'), findsOneWidget);
  });
}
