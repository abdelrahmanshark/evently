import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

/// "Don't have an account? Create account" style row.
class AuthSwitchRow extends StatelessWidget {
  const AuthSwitchRow({
    super.key,
    required this.message,
    required this.actionText,
    required this.onPressed,
  });

  final String message;
  final String actionText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, style: Theme.of(context).textTheme.bodyMedium),
        TextButton(
          onPressed: onPressed,
          child: Text(
            actionText,
            style: AppStyles.primaryBold16.copyWith(
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              decorationColor: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
