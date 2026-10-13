import 'package:evently/di/injection.dart';
import 'package:evently/domain/repositories/auth_repository.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/my_user.dart';
import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/providers/app_providers.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/auth/login_view/login_view.dart';
import 'package:evently/ui/auth/register_view/register_view.dart';
import 'package:evently/ui/home_view/add_event_view/add_event_view.dart';
import 'package:evently/ui/home_view/add_event_view/event_map_view/event_map_view.dart';
import 'package:evently/ui/home_view/add_event_view/view_model/pick_location_view_model.dart';
import 'package:evently/ui/home_view/home_view.dart';
import 'package:evently/ui/home_view/my_events_view/event_details_view/event_details_view.dart';
import 'package:evently/ui/home_view/my_events_view/my_events_view.dart';
import 'package:evently/ui/on_boarding/init_view/init_view.dart';
import 'package:evently/ui/on_boarding/intro_view/intro_view.dart';
import 'package:evently/ui/splash_view/splash_view.dart';
import 'package:evently/utils/app_messenger.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:evently/utils/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  configureDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final bool shouldShowIntro = await getShouldShowIntro();
  final String languageCode = await getLanguageCode();
  final ThemeMode themeMode = await getThemeMode();
  final MyUser? signedInUser = getIt<AuthRepository>().isSignedIn()
      ? await getSignedInUser()
      : null;
  runApp(
    AppProviders(
      languageCode: languageCode,
      themeMode: themeMode,
      signedInUser: signedInUser,
      child: Evently(
        shouldShowIntro: shouldShowIntro,
        isSignedIn: signedInUser != null,
      ),
    ),
  );
}

class Evently extends StatelessWidget {
  const Evently({
    super.key,
    required this.shouldShowIntro,
    required this.isSignedIn,
  });

  final bool shouldShowIntro;
  final bool isSignedIn;

  /// Picks the screen after the splash: intro, then home if signed in,
  /// otherwise login.
  String _routeAfterSplash() {
    if (shouldShowIntro) return AppRoutes.initRouteName;
    if (isSignedIn) return AppRoutes.homeRouteName;
    return AppRoutes.loginRouteName;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: AppMessenger.scaffoldMessengerKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(context.watch<AppLocalProvider>().appLocal),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<AppThemeProvider>().appTheme,
      initialRoute: AppRoutes.splashRouteName,
      routes: {
        AppRoutes.splashRouteName: (_) =>
            SplashView(nextRouteName: _routeAfterSplash()),
        AppRoutes.initRouteName: (_) => const InitView(),
        AppRoutes.introRouteName: (_) => const IntroView(),
        AppRoutes.loginRouteName: (_) => const LoginView(),
        AppRoutes.registerRouteName: (_) => const RegisterView(),
        AppRoutes.homeRouteName: (_) => const HomeView(),
        AppRoutes.addEventRouteName: (_) => const AddEventView(),
        AppRoutes.eventMapRouteName: (context) {
          final PickLocationViewModel viewModel =
              ModalRoute.of(context)!.settings.arguments
                  as PickLocationViewModel;
          return ChangeNotifierProvider.value(
            value: viewModel,
            child: const EventMapView(),
          );
        },
        AppRoutes.myEventsRouteName: (_) => const MyEventsView(),
        AppRoutes.eventDetailsRouteName: (context) => EventDetailsView(
          event: ModalRoute.of(context)!.settings.arguments as Event,
        ),
        AppRoutes.editEventRouteName: (context) => AddEventView(
          eventToEdit: ModalRoute.of(context)!.settings.arguments as Event,
        ),
      },
    );
  }
}
