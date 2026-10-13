import 'package:evently/di/injection.dart';
import 'package:evently/models/my_user.dart';
import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    super.key,
    required this.languageCode,
    required this.themeMode,
    required this.signedInUser,
    required this.child,
  });

  /// Saved values, read before `runApp` so the first frame is already correct.
  final String languageCode;
  final ThemeMode themeMode;
  final MyUser? signedInUser;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLocalProvider(languageCode)),
        ChangeNotifierProvider(create: (_) => AppThemeProvider(themeMode)),
        ChangeNotifierProvider(
          // Cascade: create the provider, then restore the saved user on it.
          create: (_) => getIt<MyUserProvider>()..currentUser = signedInUser,
        ),
      ],
      child: child,
    );
  }
}
