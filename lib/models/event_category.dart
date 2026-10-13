import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';

class EventCategory {
  const EventCategory({
    required this.id,
    required this.icon,
    required this.illustration,
    required this.nameRect,
    required this.illustrationRect,
  });

  /// Width and height of the canvas that [nameRect] and [illustrationRect] are measured on.
  static const Size artSize = Size(1920, 1080);

  /// Stored on each event, e.g. `sport`.
  final String id;
  final IconData icon;

  /// Transparent illustration drawn on the category art.
  final String illustration;

  /// Where the category name is drawn on the [artSize] canvas.
  final Rect nameRect;

  /// Where the [illustration] is drawn on the [artSize] canvas.
  final Rect illustrationRect;

  static const List<EventCategory> all = [
    EventCategory(
      id: 'sport',
      icon: Icons.directions_bike,
      illustration: AppAssets.sportIllustration,
      nameRect: Rect.fromLTRB(119, 379, 1058, 701),
      illustrationRect: Rect.fromLTRB(1058, 0, 1920, 1080),
    ),
    EventCategory(
      id: 'birthday',
      icon: Icons.cake_outlined,
      illustration: AppAssets.birthdayIllustration,
      nameRect: Rect.fromLTRB(111, 343, 1809, 737),
      illustrationRect: Rect.fromLTRB(515, 57, 1405, 1023),
    ),
    EventCategory(
      id: 'meeting',
      icon: Icons.laptop_chromebook,
      illustration: AppAssets.meetingIllustration,
      nameRect: Rect.fromLTRB(110, 449, 847, 631),
      illustrationRect: Rect.fromLTRB(847, 0, 1920, 1061),
    ),
    EventCategory(
      id: 'gaming',
      icon: Icons.gamepad_outlined,
      illustration: AppAssets.gamingIllustration,
      nameRect: Rect.fromLTRB(223, 336, 1697, 745),
      illustrationRect: Rect.fromLTRB(522, 57, 1399, 1024),
    ),
    EventCategory(
      id: 'eating',
      icon: Icons.fastfood,
      illustration: AppAssets.eatingIllustration,
      nameRect: Rect.fromLTRB(207, 428, 907, 652),
      illustrationRect: Rect.fromLTRB(907, 12, 1892, 1069),
    ),
    EventCategory(
      id: 'holiday',
      icon: Icons.beach_access_outlined,
      illustration: AppAssets.holidayIllustration,
      nameRect: Rect.fromLTRB(1032, 433, 1851, 647),
      illustrationRect: Rect.fromLTRB(-52, 30, 1032, 1050),
    ),
    EventCategory(
      id: 'exhibition',
      icon: Icons.collections_bookmark_outlined,
      illustration: AppAssets.exhibitionIllustration,
      nameRect: Rect.fromLTRB(95, 75, 1826, 371),
      illustrationRect: Rect.fromLTRB(518, 0, 1402, 1057),
    ),
    EventCategory(
      id: 'workShop',
      icon: Icons.work_outline_sharp,
      illustration: AppAssets.workShopIllustration,
      nameRect: Rect.fromLTRB(116, 394, 1805, 686),
      illustrationRect: Rect.fromLTRB(519, 51, 1401, 1029),
    ),
    EventCategory(
      id: 'book_club',
      icon: Icons.my_library_books_outlined,
      illustration: AppAssets.bookClubIllustration,
      nameRect: Rect.fromLTRB(139, 417, 1781, 662),
      illustrationRect: Rect.fromLTRB(508, 88, 1412, 992),
    ),
  ];

  /// Returns the category with [id], or the first category when the id is unknown.
  static EventCategory byId(String id) {
    return all.firstWhere(
      (category) => category.id == id,
      orElse: () => all.first,
    );
  }
}
