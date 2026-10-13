import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

/// Asks the user to confirm deleting an event. Pops with true when confirmed.
class DeleteEventDialog extends StatelessWidget {
  const DeleteEventDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.cardColor,
      title: Text(text.delete_event, style: AppStyles.primaryMed20),
      content: Text(
        text.delete_event_confirmation,
        style: theme.textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(text.cancel, style: AppStyles.primaryMed16),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(text.delete, style: AppStyles.redMed16),
        ),
      ],
    );
  }
}
