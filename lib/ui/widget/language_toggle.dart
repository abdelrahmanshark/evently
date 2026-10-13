import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalProvider localProvider = context.watch<AppLocalProvider>();
    return AnimatedToggleSwitch<String>.rolling(
      current: localProvider.appLocal,
      values: const ['en', 'ar'],
      onChanged: localProvider.changeLanguage,
      iconList: [
        SvgPicture.asset(AppAssets.englishFlag),
        SvgPicture.asset(AppAssets.arabicFlag),
      ],
      height: 37,
      style: const ToggleStyle(
        backgroundColor: Colors.transparent,
        borderColor: AppColors.primaryColor,
        indicatorColor: AppColors.primaryColor,
      ),
    );
  }
}
