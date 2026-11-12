/// One item on a checklist, e.g. "Laptop charger".
class ChecklistItem {
  final String id;
  final String name;

  /// How many times the item was forgotten in total.
  final int totalForgets;

  /// How many times the item was forgotten in the checklist's last 5 sessions.
  final int recentForgets;

  const ChecklistItem({
    required this.id,
    required this.name,
    this.totalForgets = 0,
    this.recentForgets = 0,
  });

  /// Ranking rule: total forgets + forgets in the last 5 sessions,
  /// so a recent forget counts twice.
  int get score => totalForgets + recentForgets;

  bool get isOftenForgotten => recentForgets > 0;
}
