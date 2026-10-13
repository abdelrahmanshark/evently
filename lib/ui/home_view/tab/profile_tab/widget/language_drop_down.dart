import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/ui/home_view/tab/profile_tab/widget/settings_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppLocalProvider localProvider = context.watch<AppLocalProvider>();
    return SettingsDropDown<String>(
      selectedValue: localProvider.appLocal,
      options: {'en': text.english, 'ar': text.arabic},
      onSelected: localProvider.changeLanguage,
    );
  }
}
