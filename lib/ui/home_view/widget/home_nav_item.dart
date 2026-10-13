import 'package:evently/utils/app_animations.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class HomeNavItem extends StatelessWidget {
  const HomeNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  final IconData icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: AppAnimations.fast,
            curve: AppAnimations.curve,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.whiteColor.withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.whiteColor),
          ),
          Text(label, style: AppStyles.whiteBold12),
        ],
      ),
    );
  }
}
