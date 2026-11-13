import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:before_go/widgets/app_text_field.dart';

Widget _wrap(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

bool _isObscured(WidgetTester tester) {
  final editable = tester.widget<EditableText>(find.byType(EditableText));
  return editable.obscureText;
}

void main() {
  testWidgets('password field is hidden until the eye icon is tapped', (tester) async {
    await tester.pumpWidget(
      _wrap(const AppTextField(label: 'Password', obscureText: true)),
    );

    expect(_isObscured(tester), isTrue);

    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();
    expect(_isObscured(tester), isFalse);

    await tester.tap(find.byIcon(Icons.visibility_off_outlined));
    await tester.pump();
    expect(_isObscured(tester), isTrue);
  });

  testWidgets('normal field has no eye icon', (tester) async {
    await tester.pumpWidget(_wrap(const AppTextField(label: 'Email')));

    expect(find.byIcon(Icons.visibility_outlined), findsNothing);
  });
}
