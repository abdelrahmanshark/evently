import 'package:evently/utils/app_animations.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventCategoryChip extends StatelessWidget {
  const EventCategoryChip({
    super.key,
    required this.name,
    required this.icon,
    this.isSelected = false,
    this.isAddEvent = false,
  });

  final String name;
  final IconData icon;
  final bool isSelected;

  /// Uses the outlined primary style of the add-event screen.
  final bool isAddEvent;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final Color backgroundColor;
    final Color borderColor;
    final Color iconColor;
    final TextStyle? textStyle;
    if (isAddEvent) {
      backgroundColor = isSelected
          ? AppColors.primaryColor
          : Colors.transparent;
      borderColor = AppColors.primaryColor;
      iconColor = isSelected ? theme.cardColor : AppColors.primaryColor;
      textStyle = isSelected ? textTheme.labelMedium : AppStyles.primaryBold16;
    } else {
      backgroundColor = isSelected ? theme.dividerColor : Colors.transparent;
      borderColor = theme.dividerColor;
      iconColor = isSelected ? theme.focusColor : AppColors.whiteColor;
      textStyle = isSelected ? textTheme.displayMedium : AppStyles.whiteMed16;
    }
    return AnimatedContainer(
      duration: AppAnimations.fast,
      curve: AppAnimations.curve,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(46),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 6),
          Text(name, style: textStyle),
        ],
      ),
    );
  }
}
