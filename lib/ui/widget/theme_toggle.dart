import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final AppThemeProvider themeProvider = context.watch<AppThemeProvider>();
    final Color selectedIconColor = Theme.of(context).cardColor;
    return AnimatedToggleSwitch<ThemeMode>.rolling(
      current: themeProvider.appTheme,
      values: const [ThemeMode.light, ThemeMode.dark],
      onChanged: themeProvider.changeAppTheme,
      iconBuilder: (value, selected) => Icon(
        value == ThemeMode.light ? Icons.sunny : Icons.dark_mode_sharp,
        color: selected ? selectedIconColor : AppColors.primaryColor,
      ),
      height: 37,
      style: const ToggleStyle(
        backgroundColor: Colors.transparent,
        borderColor: AppColors.primaryColor,
        indicatorColor: AppColors.primaryColor,
      ),
    );
  }
}
