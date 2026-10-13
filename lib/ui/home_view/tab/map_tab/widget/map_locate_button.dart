import 'package:evently/ui/widget/pressable_scale.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Rounded button that moves the map to the user's location.
class MapLocateButton extends StatelessWidget {
  const MapLocateButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset(
              AppAssets.locateIcon,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                Theme.of(context).cardColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
