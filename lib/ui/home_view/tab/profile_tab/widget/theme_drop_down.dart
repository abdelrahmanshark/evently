import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/home_view/tab/profile_tab/widget/settings_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeDropDown extends StatelessWidget {
  const ThemeDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppThemeProvider themeProvider = context.watch<AppThemeProvider>();
    return SettingsDropDown<ThemeMode>(
      selectedValue: themeProvider.appTheme,
      options: {ThemeMode.light: text.light, ThemeMode.dark: text.dark},
      onSelected: themeProvider.changeAppTheme,
    );
  }
}
