import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get home_title;

  /// No description provided for @home_body.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'**
  String get home_body;

  /// No description provided for @ob1_title.
  ///
  /// In en, this message translates to:
  /// **'Find Events That Inspire You'**
  String get ob1_title;

  /// No description provided for @ob1_body.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.'**
  String get ob1_body;

  /// No description provided for @ob2_title.
  ///
  /// In en, this message translates to:
  /// **'Effortless Event Planning'**
  String get ob2_title;

  /// No description provided for @ob2_body.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.'**
  String get ob2_body;

  /// No description provided for @ob3_title.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends & Share Moments'**
  String get ob3_title;

  /// No description provided for @ob3_body.
  ///
  /// In en, this message translates to:
  /// **'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.'**
  String get ob3_body;

  /// No description provided for @lets_start.
  ///
  /// In en, this message translates to:
  /// **'Let’s Start'**
  String get lets_start;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forget_password_q.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forget_password_q;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t Have Account ?'**
  String get dont_have_account;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **' Create Account'**
  String get create_account;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @login_with_google.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get login_with_google;

  /// No description provided for @re_password.
  ///
  /// In en, this message translates to:
  /// **'Re Password'**
  String get re_password;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account ?'**
  String get already_have_account;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back ✨'**
  String get welcome_back;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get en;

  /// No description provided for @ar.
  ///
  /// In en, this message translates to:
  /// **'AR'**
  String get ar;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sport;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @book_club.
  ///
  /// In en, this message translates to:
  /// **'Book Club'**
  String get book_club;

  /// No description provided for @eating.
  ///
  /// In en, this message translates to:
  /// **'Eating'**
  String get eating;

  /// No description provided for @exhibition.
  ///
  /// In en, this message translates to:
  /// **'Exhibition'**
  String get exhibition;

  /// No description provided for @gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get gaming;

  /// No description provided for @holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get holiday;

  /// No description provided for @meeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get meeting;

  /// No description provided for @workShop.
  ///
  /// In en, this message translates to:
  /// **'Work Shop'**
  String get workShop;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @love.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get love;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forget_password;

  /// No description provided for @search_for_events.
  ///
  /// In en, this message translates to:
  /// **'Search For Events'**
  String get search_for_events;

  /// No description provided for @create_event.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get create_event;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @event_title.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get event_title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @event_description.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get event_description;

  /// No description provided for @event_date.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get event_date;

  /// No description provided for @choose_date.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get choose_date;

  /// No description provided for @event_time.
  ///
  /// In en, this message translates to:
  /// **'Event Time'**
  String get event_time;

  /// No description provided for @choose_time.
  ///
  /// In en, this message translates to:
  /// **'Choose Time'**
  String get choose_time;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @choose_event_location.
  ///
  /// In en, this message translates to:
  /// **'Choose Event Location'**
  String get choose_event_location;

  /// No description provided for @add_event.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get add_event;

  /// No description provided for @event_details.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get event_details;

  /// No description provided for @edit_event.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get edit_event;

  /// No description provided for @update_event.
  ///
  /// In en, this message translates to:
  /// **'Update Event'**
  String get update_event;

  /// No description provided for @tap_on_location_to_select.
  ///
  /// In en, this message translates to:
  /// **'Tap On Location To Select'**
  String get tap_on_location_to_select;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @please_enter_an_email.
  ///
  /// In en, this message translates to:
  /// **'please enter an email'**
  String get please_enter_an_email;

  /// No description provided for @please_enter_a_password.
  ///
  /// In en, this message translates to:
  /// **'please enter a password'**
  String get please_enter_a_password;

  /// No description provided for @password_must_be_at_least_6_char.
  ///
  /// In en, this message translates to:
  /// **'password must be at least 6 char'**
  String get password_must_be_at_least_6_char;

  /// No description provided for @re_password_dosnt_match.
  ///
  /// In en, this message translates to:
  /// **'re password dosen\'t match'**
  String get re_password_dosnt_match;

  /// No description provided for @please_enter_a_valid_email.
  ///
  /// In en, this message translates to:
  /// **'please enter a valid email'**
  String get please_enter_a_valid_email;

  /// No description provided for @please_enter_a_valid_password.
  ///
  /// In en, this message translates to:
  /// **'please enter a valid password'**
  String get please_enter_a_valid_password;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @please_enter_your_name.
  ///
  /// In en, this message translates to:
  /// **'please enter your name'**
  String get please_enter_your_name;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @please_enter_event_title.
  ///
  /// In en, this message translates to:
  /// **'please enter event title'**
  String get please_enter_event_title;

  /// No description provided for @please_enter_event_discription.
  ///
  /// In en, this message translates to:
  /// **'please enter event discription'**
  String get please_enter_event_discription;

  /// No description provided for @please_enter_event_date.
  ///
  /// In en, this message translates to:
  /// **'please enter event date'**
  String get please_enter_event_date;

  /// No description provided for @please_enter_event_time.
  ///
  /// In en, this message translates to:
  /// **'please enter event time'**
  String get please_enter_event_time;

  /// No description provided for @please_select_event_location.
  ///
  /// In en, this message translates to:
  /// **'please select event location'**
  String get please_select_event_location;

  /// No description provided for @event_added.
  ///
  /// In en, this message translates to:
  /// **'Event Added'**
  String get event_added;

  /// No description provided for @event_added_to_favorite.
  ///
  /// In en, this message translates to:
  /// **'Event Added to favorite'**
  String get event_added_to_favorite;

  /// No description provided for @event_removed_from_favorite.
  ///
  /// In en, this message translates to:
  /// **'Event Remove From Favorite'**
  String get event_removed_from_favorite;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @register_Successfully.
  ///
  /// In en, this message translates to:
  /// **'Register Successfully'**
  String get register_Successfully;

  /// No description provided for @login_Successfully.
  ///
  /// In en, this message translates to:
  /// **'Login Successfully'**
  String get login_Successfully;

  /// No description provided for @the_password_provided_is_too_weak.
  ///
  /// In en, this message translates to:
  /// **'The password provided is too weak'**
  String get the_password_provided_is_too_weak;

  /// No description provided for @the_account_already_exists_for_that_email.
  ///
  /// In en, this message translates to:
  /// **'The account already exists for that email.'**
  String get the_account_already_exists_for_that_email;

  /// No description provided for @wrong_email_or_password.
  ///
  /// In en, this message translates to:
  /// **'Wrong email or password'**
  String get wrong_email_or_password;

  /// No description provided for @go_to_my_events.
  ///
  /// In en, this message translates to:
  /// **'Go to my event'**
  String get go_to_my_events;

  /// No description provided for @my_event.
  ///
  /// In en, this message translates to:
  /// **'My Events'**
  String get my_event;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again'**
  String get something_went_wrong;

  /// No description provided for @no_events_found.
  ///
  /// In en, this message translates to:
  /// **'No events found'**
  String get no_events_found;

  /// No description provided for @unknown_location.
  ///
  /// In en, this message translates to:
  /// **'Unknown location'**
  String get unknown_location;

  /// No description provided for @event_updated.
  ///
  /// In en, this message translates to:
  /// **'Event Updated'**
  String get event_updated;

  /// No description provided for @event_deleted.
  ///
  /// In en, this message translates to:
  /// **'Event Deleted'**
  String get event_deleted;

  /// No description provided for @delete_event.
  ///
  /// In en, this message translates to:
  /// **'Delete Event'**
  String get delete_event;

  /// No description provided for @delete_event_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this event?'**
  String get delete_event_confirmation;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
