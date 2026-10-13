import 'package:evently/models/app_failure.dart';
import 'package:evently/models/event.dart';
import 'package:evently/utils/arabic_normalizer.dart';

class FavoritesState {
  const FavoritesState({
    this.favorites = const [],
    this.searchText = '',
    this.isLoading = false,
    this.failure,
  });

  final List<Event> favorites;
  final String searchText;
  final bool isLoading;
  final AppFailure? failure;

  /// Favorites whose title matches the search text (Arabic-normalized).
  List<Event> get visibleFavorites {
    final String query = normalizeArabic(searchText.trim().toLowerCase());
    if (query.isEmpty) return favorites;
    return favorites
        .where(
          (event) =>
              normalizeArabic(event.title.toLowerCase()).contains(query),
        )
        .toList();
  }

  /// Whether the event with [eventId] is a favorite.
  bool isFavorite(String eventId) {
    return favorites.any((event) => event.id == eventId);
  }

  /// Returns a copy with the given values; [failure] is cleared unless passed.
  FavoritesState copyWith({
    List<Event>? favorites,
    String? searchText,
    bool? isLoading,
    AppFailure? failure,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      searchText: searchText ?? this.searchText,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }
}
