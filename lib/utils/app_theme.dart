import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_images.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/event_category_art_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    cardColor: AppColors.primaryLightColor,
    canvasColor: AppColors.primaryDarkColor,
    primaryColor: AppColors.primaryColor,
    dividerColor: AppColors.whiteColor,
    focusColor: AppColors.primaryColor,
    disabledColor: AppColors.grayColor,
    scaffoldBackgroundColor: AppColors.primaryLightColor,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(
          backgroundColor: AppColors.primaryLightColor,
        ),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    extensions: const [
      AppImages(
        home: AppAssets.homeLightImage,
        oB2: AppAssets.ob2LightImage,
        oB3: AppAssets.ob3LightImage,
      ),
      EventCategoryArtStyle(
        backgroundColor: AppColors.blackColor,
        nameStyle: AppStyles.primaryLightBold300,
      ),
    ],
    textTheme: const TextTheme(
      headlineLarge: AppStyles.primaryBold20,
      headlineMedium: AppStyles.primaryMed20,
      bodyMedium: AppStyles.blackMed16,
      bodyLarge: AppStyles.blackBold20,
      displayLarge: AppStyles.primaryBold14,
      displayMedium: AppStyles.primaryMed16,
      bodySmall: AppStyles.blackBold14,
      titleSmall: AppStyles.blackMed14,
      labelSmall: AppStyles.grayMed16,
      labelMedium: AppStyles.whiteMed16,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.whiteColor, width: 6),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionColor: AppColors.primaryColor,
      selectionHandleColor: AppColors.primaryColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDarkColor,
    cardColor: AppColors.primaryDarkColor,
    canvasColor: AppColors.primaryLightColor,
    dividerColor: AppColors.primaryColor,
    focusColor: AppColors.whiteColor,
    disabledColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.primaryDarkColor,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(
          backgroundColor: AppColors.primaryDarkColor,
        ),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    extensions: const [
      AppImages(
        home: AppAssets.homeDarkImage,
        oB2: AppAssets.ob2DarkImage,
        oB3: AppAssets.ob3DarkImage,
      ),
      EventCategoryArtStyle(
        backgroundColor: AppColors.primaryDarkColor,
        nameStyle: AppStyles.offWhiteBold300,
      ),
    ],
    textTheme: const TextTheme(
      headlineLarge: AppStyles.primaryBold20,
      headlineMedium: AppStyles.primaryMed20,
      bodyMedium: AppStyles.whiteMed16,
      bodyLarge: AppStyles.whiteBold20,
      displayLarge: AppStyles.blackBold14,
      displayMedium: AppStyles.whiteMed16,
      bodySmall: AppStyles.whiteBold14,
      titleSmall: AppStyles.offWhiteMed14,
      labelSmall: AppStyles.whiteMed16,
      labelMedium: AppStyles.blackMed16,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDarkColor,
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.whiteColor, width: 6),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionColor: AppColors.primaryColor,
      selectionHandleColor: AppColors.primaryColor,
    ),
  );
}
