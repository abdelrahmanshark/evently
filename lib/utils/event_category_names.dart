import 'package:evently/l10n/app_localizations.dart';

class EventCategoryNames {
  /// Returns the translated name of an event category id (e.g. `sport`).
  static String nameOf(AppLocalizations l10n, String categoryId) {
    switch (categoryId) {
      case 'sport':
        return l10n.sport;
      case 'birthday':
        return l10n.birthday;
      case 'meeting':
        return l10n.meeting;
      case 'gaming':
        return l10n.gaming;
      case 'eating':
        return l10n.eating;
      case 'holiday':
        return l10n.holiday;
      case 'exhibition':
        return l10n.exhibition;
      case 'workShop':
        return l10n.workShop;
      case 'book_club':
        return l10n.book_club;
      default:
        return categoryId;
    }
  }
}
