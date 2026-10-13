import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTabAppBarTitle extends StatelessWidget {
  const HomeTabAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final String userName =
        context.watch<MyUserProvider>().currentUser?.name ?? '';
    final bool isLight = context.watch<AppThemeProvider>().isLight;
    final bool isEnglish = context.watch<AppLocalProvider>().isEnglish;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text.welcome_back, style: AppStyles.whiteMed14),
            Text(userName, style: AppStyles.whiteBold24),
          ],
        ),
        const Spacer(),
        Icon(
          isLight ? Icons.sunny : Icons.dark_mode,
          color: AppColors.whiteColor,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsetsDirectional.only(start: 10, end: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.whiteColor,
          ),
          child: Text(
            isEnglish ? text.en : text.ar,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ],
    );
  }
}
