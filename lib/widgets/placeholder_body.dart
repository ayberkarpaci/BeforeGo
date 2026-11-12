import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';

/// A button on a placeholder screen that opens another screen.
class PlaceholderLink {
  final String label;
  final String route;
  final Object? arguments;

  /// Removes every previous screen, e.g. after logging in or out.
  final bool clearStack;

  const PlaceholderLink(
    this.label,
    this.route, {
    this.arguments,
    this.clearStack = false,
  });
}

/// Temporary body for screens that are not built yet. The owner replaces it
/// with the real screen; the links keep the navigation flow working meanwhile.
class PlaceholderBody extends StatelessWidget {
  final String owner;
  final List<PlaceholderLink> links;

  const PlaceholderBody({
    super.key,
    required this.owner,
    this.links = const [],
  });

  void _open(BuildContext context, PlaceholderLink link) {
    final navigator = Navigator.of(context);
    if (link.clearStack) {
      navigator.pushNamedAndRemoveUntil(
        link.route,
        (route) => false,
        arguments: link.arguments,
      );
    } else {
      navigator.pushNamed(link.route, arguments: link.arguments);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: AppSpacing.page,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.construction_outlined,
              size: 48,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'This screen is not built yet',
              style: AppTextStyles.heading,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text('Owner: $owner', style: AppTextStyles.caption),
            const SizedBox(height: AppSpacing.lg),
            for (final link in links)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: OutlinedButton(
                  onPressed: () => _open(context, link),
                  child: Text(link.label),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
