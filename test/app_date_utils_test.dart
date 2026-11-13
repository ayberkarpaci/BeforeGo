import 'package:flutter_test/flutter_test.dart';

import 'package:before_go/utils/app_date_utils.dart';

void main() {
  final now = DateTime(2026, 11, 13, 15, 30);

  test('shortDate and longDate use short month names', () {
    expect(AppDateUtils.shortDate(DateTime(2026, 11, 3)), '3 Nov');
    expect(AppDateUtils.longDate(DateTime(2026, 1, 25)), '25 Jan 2026');
  });

  test('relativeDate describes recent days in words', () {
    expect(AppDateUtils.relativeDate(DateTime(2026, 11, 13, 8), now: now), 'today');
    expect(AppDateUtils.relativeDate(DateTime(2026, 11, 12, 23), now: now), 'yesterday');
    expect(AppDateUtils.relativeDate(DateTime(2026, 11, 8), now: now), '5 days ago');
    expect(AppDateUtils.relativeDate(DateTime(2026, 10, 24), now: now), '24 Oct');
  });

  test('lastPackedLabel handles checklists that were never packed', () {
    expect(AppDateUtils.lastPackedLabel(null, now: now), 'Not packed yet');
    expect(
      AppDateUtils.lastPackedLabel(DateTime(2026, 11, 10), now: now),
      'Last packed 3 days ago',
    );
  });
}
