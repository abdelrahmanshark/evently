import 'package:evently/models/app_failure.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/event_category.dart';

class HomeTabState {
  const HomeTabState({
    this.allEvents = const [],
    this.selectedIndex = 0,
    this.isLoading = false,
    this.failure,
  });

  final List<Event> allEvents;

  /// 0 is the "All" tab; index `i` is `EventCategory.all[i - 1]`.
  final int selectedIndex;
  final bool isLoading;
  final AppFailure? failure;

  /// Events of the selected category (or all events).
  List<Event> get visibleEvents {
    if (selectedIndex == 0) return allEvents;
    final String categoryId = EventCategory.all[selectedIndex - 1].id;
    return allEvents.where((event) => event.categoryId == categoryId).toList();
  }

  /// Returns a copy with the given values; [failure] is cleared unless passed.
  HomeTabState copyWith({
    List<Event>? allEvents,
    int? selectedIndex,
    bool? isLoading,
    AppFailure? failure,
  }) {
    return HomeTabState(
      allEvents: allEvents ?? this.allEvents,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }
}
