import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Bordered box with a primary icon badge, [child], and an optional [trailing].
class EventInfoTile extends StatelessWidget {
  const EventInfoTile({
    super.key,
    required this.iconAsset,
    required this.child,
    this.trailing,
  });

  final String iconAsset;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              iconAsset,
              colorFilter: ColorFilter.mode(
                Theme.of(context).cardColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: child),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
