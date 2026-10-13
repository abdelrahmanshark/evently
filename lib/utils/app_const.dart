import 'package:evently/providers/map_provider.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_local_provider.dart';
import '../providers/app_theme_provider.dart';
import 'app_themes.dart';

class AppConst {
  BuildContext context;

  AppConst(this.context);

  ThemeData get theme => Theme.of(context);

  AppImages get image => theme.extension<AppImages>()!;

  AppLocalizations get text => AppLocalizations.of(context)!;

  TextTheme get textStyle => theme.textTheme;

  AppThemeProvider get themeProvider => Provider.of<AppThemeProvider>(context);

  MyUserProvider get myUserProvider => Provider.of<MyUserProvider>(context);

  AppLocalProvider get localProvider => Provider.of<AppLocalProvider>(context);

  double get height => MediaQuery.of(context).size.height;

  double get width => MediaQuery.of(context).size.width;

  MapProvider get mapProvider => Provider.of<MapProvider>(context);
}
