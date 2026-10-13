import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/ui/home_view/tab/profile_tab/widget/language_drop_down.dart';
import 'package:evently/ui/home_view/tab/profile_tab/widget/profile_header.dart';
import 'package:evently/ui/home_view/tab/profile_tab/widget/theme_drop_down.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/ui/widget/fill_or_scroll_view.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.sizeOf(context).height * .18,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
        ),
        title: const ProfileHeader(),
      ),
      body: FillOrScrollView(
        // The large bottom padding keeps the logout button above the bottom nav bar.
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(text.language, style: textTheme.bodyLarge),
                const SizedBox(height: 10),
                const LanguageDropDown(),
                const SizedBox(height: 30),
                Text(text.theme, style: textTheme.bodyLarge),
                const SizedBox(height: 10),
                const ThemeDropDown(),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.myEventsRouteName),
                  child: Text(text.go_to_my_events, style: textTheme.bodyLarge),
                ),
                const SizedBox(height: 20),
              ],
            ),
            CustomElevatedButton(
              onPressed: () => context.read<MyUserProvider>().logout(context),
              backGroundColor: AppColors.redColor,
              child: Row(
                children: [
                  const Icon(Icons.exit_to_app, color: AppColors.whiteColor),
                  const SizedBox(width: 10),
                  Text(text.logout, style: AppStyles.whiteMed20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
