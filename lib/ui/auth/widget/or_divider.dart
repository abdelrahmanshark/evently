import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.primaryColor,
            thickness: 2,
            endIndent: 10,
            indent: 12,
          ),
        ),
        Text(text, style: AppStyles.primaryMed16),
        const Expanded(
          child: Divider(
            color: AppColors.primaryColor,
            thickness: 2,
            endIndent: 10,
            indent: 12,
          ),
        ),
      ],
    );
  }
}
