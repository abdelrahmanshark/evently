import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backGroundColor,
    this.borderColor,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color? backGroundColor;
  final Color? borderColor;

  /// Shows a small spinner instead of [child] and ignores taps.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final Color background = backGroundColor ?? AppColors.primaryColor;
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: borderColor ?? Colors.transparent, width: 2),
        elevation: 0,
        backgroundColor: background,
        disabledBackgroundColor: background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(10),
      ),
      child: isLoading
          ? const SizedBox(
              height: 26,
              width: 26,
              child: CircularProgressIndicator(
                color: AppColors.whiteColor,
                strokeWidth: 2.5,
              ),
            )
          : child,
    );
  }
}
