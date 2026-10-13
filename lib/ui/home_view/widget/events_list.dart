import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/app_failure.dart';
import 'package:evently/models/event.dart';
import 'package:evently/ui/home_view/widget/event_card.dart';
import 'package:evently/ui/home_view/widget/favorite_button.dart';
import 'package:evently/ui/widget/app_loading_indicator.dart';
import 'package:evently/ui/widget/fade_in.dart';
import 'package:evently/ui/widget/retry_view.dart';
import 'package:evently/utils/failure_messages.dart';
import 'package:flutter/material.dart';

/// Shows the loading, error, empty, or list state of a list of events.
class EventsList extends StatelessWidget {
  const EventsList({
    super.key,
    required this.events,
    required this.isLoading,
    required this.failure,
    required this.onRetry,
    this.showFavoriteButton = true,
    this.onEventTap,
  });

  final List<Event> events;
  final bool isLoading;
  final AppFailure? failure;
  final VoidCallback onRetry;

  /// Needs a `FavoritesCubit` above this widget when true.
  final bool showFavoriteButton;

  /// Called with the tapped event. Cards aren't tappable when null.
  final ValueChanged<Event>? onEventTap;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    if (isLoading) {
      return const FadeIn(
        key: ValueKey('loading'),
        child: AppLoadingIndicator(),
      );
    }
    if (failure != null) {
      return FadeIn(
        key: const ValueKey('failure'),
        child: RetryView(
          message: FailureMessages.messageFor(text, failure!),
          onRefresh: onRetry,
        ),
      );
    }
    if (events.isEmpty) {
      return FadeIn(
        key: const ValueKey('empty'),
        child: Center(
          child: Text(
            text.no_events_found,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      );
    }
    return FadeIn(
      key: const ValueKey('content'),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: events.length,
        itemBuilder: (context, index) => EventCard(
          event: events[index],
          trailing: showFavoriteButton
              ? FavoriteButton(event: events[index])
              : null,
          onTap: onEventTap == null
              ? null
              : () => onEventTap!(events[index]),
        ),
      ),
    );
  }
}
