import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/ui/widget/fill_or_scroll_view.dart';
import 'package:evently/ui/widget/language_toggle.dart';
import 'package:evently/ui/widget/theme_toggle.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_images.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class InitView extends StatelessWidget {
  const InitView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppImages images = theme.extension<AppImages>()!;
    final AppLocalizations text = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: FillOrScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 12,
            children: [
              Image.asset(AppAssets.eventlyHeader),
              Image.asset(
                images.home,
                height: MediaQuery.sizeOf(context).height * .35,
              ),
              Text(text.home_title, style: theme.textTheme.headlineLarge),
              Text(text.home_body, style: theme.textTheme.bodyMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text.language, style: theme.textTheme.headlineMedium),
                  const LanguageToggle(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text.theme, style: theme.textTheme.headlineMedium),
                  const ThemeToggle(),
                ],
              ),
              CustomElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.introRouteName),
                child: Text(text.lets_start, style: AppStyles.whiteMed20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
