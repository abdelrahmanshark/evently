import 'package:evently/models/my_user.dart';
import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// User image, name, and email shown in the profile app bar.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final MyUser? user = context.watch<MyUserProvider>().currentUser;
    final bool isEnglish = context.watch<AppLocalProvider>().isEnglish;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(1000),
            bottomRight: const Radius.circular(1000),
            topRight: Radius.circular(isEnglish ? 1000 : 24),
            topLeft: Radius.circular(isEnglish ? 24 : 1000),
          ),
          child: Image.asset(AppAssets.routeImage),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user?.name ?? '', style: AppStyles.whiteBold24),
              const SizedBox(height: 6),
              Text(
                user?.email ?? '',
                style: AppStyles.whiteMed16,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
