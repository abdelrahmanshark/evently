import 'package:evently/ui/on_boarding/intro_view/widget/dot_indicator.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class IntroNavigationRow extends StatelessWidget {
  const IntroNavigationRow({
    super.key,
    required this.currentIndex,
    required this.pageCount,
    required this.onBack,
    required this.onNext,
  });

  final int currentIndex;
  final int pageCount;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Keeps the dots centered while the back button is hidden.
          Visibility.maintain(
            visible: currentIndex != 0,
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                color: AppColors.primaryColor,
                size: 40,
              ),
            ),
          ),
          Row(
            children: [
              for (int index = 0; index < pageCount; index++)
                DotIndicator(isActive: currentIndex == index),
            ],
          ),
          IconButton(
            onPressed: onNext,
            icon: const Icon(
              Icons.arrow_circle_right_outlined,
              color: AppColors.primaryColor,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
