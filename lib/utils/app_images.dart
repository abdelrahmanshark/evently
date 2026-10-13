import 'package:flutter/material.dart';

/// Theme-dependent image paths (light and dark variants), read with
/// `Theme.of(context).extension<AppImages>()!`.
class AppImages extends ThemeExtension<AppImages> {
  const AppImages({required this.home, required this.oB2, required this.oB3});

  final String home;
  final String oB2;
  final String oB3;

  /// Returns a copy with the given images replaced.
  @override
  AppImages copyWith({String? home, String? oB2, String? oB3}) {
    return AppImages(
      home: home ?? this.home,
      oB2: oB2 ?? this.oB2,
      oB3: oB3 ?? this.oB3,
    );
  }

  /// Image paths can't be interpolated, so the current set is kept.
  @override
  AppImages lerp(covariant ThemeExtension<AppImages>? other, double t) {
    return this;
  }
}
