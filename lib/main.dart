import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_map_provider.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/ui/authentication/login/login_screen.dart';
import 'package:evently/ui/authentication/register/register_screen.dart';
import 'package:evently/ui/home/add_event/add_event.dart';
import 'package:evently/ui/home/add_event/event_map.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/ui/home/tabs/profile/my_events.dart';
import 'package:evently/ui/home/tabs/profile/profile_tab.dart';
import 'package:evently/ui/on_boarding/init_screen/init_screen.dart';
import 'package:evently/ui/on_boarding/intro_screens/introduction_screens.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_themes.dart';
import 'package:evently/utils/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool isSeen = await chackedIsIntroSeen();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLocalProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => MyUserProvider()),
      ],
      child: Evently(isSeen: isSeen),
    ),
  );
}

Future<bool> chackedIsIntroSeen() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getBool(SharedPreferencesKay.isSeenKey) ?? true;
}

class Evently extends StatelessWidget {
  Evently({super.key, required this.isSeen});

  bool isSeen;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var localProvider = Provider.of<AppLocalProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localProvider.appLocal),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.appTheme,
      initialRoute: isSeen
          ? AppRoutes.initScreenRouteName
          : AppRoutes.loginScreensRouteName,
      routes: {
        AppRoutes.initScreenRouteName: (context) => InitScreen(),
        AppRoutes.introScreensRouteName: (context) => IntroductionScreens(),
        AppRoutes.loginScreensRouteName: (context) => LoginScreen(),
        AppRoutes.profileTabRouteName: (context) => ProfileTab(),
        AppRoutes.homeScreenRouteName: (context) => HomeScreen(),
        AppRoutes.registerScreensRouteName: (context) => RegisterScreen(),
        AppRoutes.addEventScreenRouteName: (context) => ChangeNotifierProvider(
          create: (context) => PickLocationProvider(),
            child: AddEvent()),
        AppRoutes.eventMapRouteName :(context) {
          PickLocationProvider provider = ModalRoute.of(context)?.settings.arguments as PickLocationProvider;
          return EventMap(pickLocationProvider:provider);
        },
        AppRoutes.myEventsRouteName: (context) => MyEvents(),
      },
    );
  }
}
