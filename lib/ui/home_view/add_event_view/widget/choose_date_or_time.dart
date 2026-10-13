import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ChooseDateOrTime extends StatelessWidget {
  const ChooseDateOrTime({
    super.key,
    required this.icon,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  final IconData icon;
  final String text;

  /// Tappable text on the end side (e.g. "Choose Date" or the chosen date).
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: theme.canvasColor),
        const SizedBox(width: 12),
        Text(text, style: theme.textTheme.bodyMedium),
        const Spacer(),
        InkWell(
          onTap: onTap,
          child: Text(actionText, style: AppStyles.primaryMed16),
        ),
      ],
    );
  }
}
