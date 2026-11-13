/// Date helpers shared by every screen, e.g. "3 Nov" or "Last packed 2 days ago".
///
/// Named AppDateUtils because Flutter's material library already has a
/// DateUtils class.
class AppDateUtils {
  AppDateUtils._();

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  /// "3 Nov"
  static String shortDate(DateTime date) => '${date.day} ${_months[date.month - 1]}';

  /// "3 Nov 2026"
  static String longDate(DateTime date) => '${shortDate(date)} ${date.year}';

  /// "today", "yesterday", "5 days ago" or "3 Nov" for older dates.
  static String relativeDate(DateTime date, {DateTime? now}) {
    final today = _dayOnly(now ?? DateTime.now());
    final days = today.difference(_dayOnly(date)).inDays;

    if (days == 0) return 'today';
    if (days == 1) return 'yesterday';
    if (days > 1 && days < 7) return '$days days ago';
    return shortDate(date);
  }

  /// "Last packed yesterday", or "Not packed yet" when there is no date.
  static String lastPackedLabel(DateTime? date, {DateTime? now}) {
    if (date == null) return 'Not packed yet';
    return 'Last packed ${relativeDate(date, now: now)}';
  }

  static DateTime _dayOnly(DateTime date) => DateTime(date.year, date.month, date.day);
}
