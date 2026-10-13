import 'package:flutter/material.dart';

/// Theme-dependent colors of the category art, read with
/// `Theme.of(context).extension<EventCategoryArtStyle>()!`.
class EventCategoryArtStyle extends ThemeExtension<EventCategoryArtStyle> {
  const EventCategoryArtStyle({
    required this.backgroundColor,
    required this.nameStyle,
  });

  final Color backgroundColor;

  /// Style of the category name drawn on the art.
  final TextStyle nameStyle;

  /// Returns a copy with the given values replaced.
  @override
  EventCategoryArtStyle copyWith({
    Color? backgroundColor,
    TextStyle? nameStyle,
  }) {
    return EventCategoryArtStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      nameStyle: nameStyle ?? this.nameStyle,
    );
  }

  /// Blends the colors so switching themes animates smoothly.
  @override
  EventCategoryArtStyle lerp(
    covariant ThemeExtension<EventCategoryArtStyle>? other,
    double t,
  ) {
    if (other is! EventCategoryArtStyle) return this;
    return EventCategoryArtStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      nameStyle: TextStyle.lerp(nameStyle, other.nameStyle, t)!,
    );
  }
}
