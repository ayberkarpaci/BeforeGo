import 'package:flutter_test/flutter_test.dart';

import 'package:before_go/widgets/app_text_field.dart';

void main() {
  group('FieldValidators.email', () {
    test('accepts a normal address', () {
      expect(FieldValidators.email('ayse@example.com'), isNull);
    });

    test('ignores spaces around the address', () {
      expect(FieldValidators.email('  ayse@example.com '), isNull);
    });

    test('rejects missing parts', () {
      for (final value in ['', 'ayse', 'ayse@', '@example.com', 'ayse@example', 'a b@example.com']) {
        expect(FieldValidators.email(value), 'Enter a valid email address', reason: value);
      }
    });

    test('rejects null', () {
      expect(FieldValidators.email(null), 'Enter a valid email address');
    });
  });

  group('FieldValidators.required', () {
    final check = FieldValidators.required('Please enter your name');

    test('passes when there is text', () {
      expect(check('Ayse'), isNull);
    });

    test('fails for null, empty and spaces only', () {
      expect(check(null), 'Please enter your name');
      expect(check(''), 'Please enter your name');
      expect(check('   '), 'Please enter your name');
    });
  });

  group('FieldValidators.password', () {
    test('needs at least 6 characters', () {
      expect(FieldValidators.password('12345'), 'Use at least 6 characters');
      expect(FieldValidators.password('123456'), isNull);
    });

    test('fails for null', () {
      expect(FieldValidators.password(null), 'Use at least 6 characters');
    });
  });

  group('FieldValidators.matches', () {
    test('compares with the current value of the other field', () {
      var other = 'secret1';
      final check = FieldValidators.matches(() => other);

      expect(check('secret1'), isNull);
      expect(check('secret2'), 'Passwords do not match');

      other = 'secret2';
      expect(check('secret2'), isNull);
    });
  });
}
