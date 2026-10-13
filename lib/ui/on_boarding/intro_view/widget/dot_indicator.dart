import 'package:evently/utils/app_animations.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppAnimations.fast,
      curve: AppAnimations.curve,
      height: 8,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: isActive
            ? AppColors.primaryColor
            : Theme.of(context).canvasColor,
      ),
    );
  }
}
