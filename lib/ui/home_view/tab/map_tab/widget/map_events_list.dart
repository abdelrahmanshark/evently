import 'package:evently/models/event.dart';
import 'package:evently/models/place_address.dart';
import 'package:evently/ui/home_view/tab/map_tab/widget/map_event_card.dart';
import 'package:evently/utils/app_animations.dart';
import 'package:flutter/material.dart';

/// Horizontal list of event cards that scrolls to the selected event.
class MapEventsList extends StatefulWidget {
  const MapEventsList({
    super.key,
    required this.events,
    required this.addresses,
    required this.selectedIndex,
    required this.onEventTap,
  });

  final List<Event> events;

  /// Looked-up addresses by event id; a missing key means still loading.
  final Map<String, PlaceAddress?> addresses;
  final int? selectedIndex;
  final ValueChanged<Event> onEventTap;

  @override
  State<MapEventsList> createState() => _MapEventsListState();
}

class _MapEventsListState extends State<MapEventsList> {
  static const double _gap = 10;
  static const double _itemExtent = MapEventCard.width + _gap;

  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(MapEventsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _scrollToSelected();
    }
  }

  /// Scrolls so the selected card starts at the list's leading edge.
  void _scrollToSelected() {
    final int? index = widget.selectedIndex;
    if (index == null || !_scrollController.hasClients) return;
    final double offset = (index * _itemExtent).clamp(
      0,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(
      offset,
      duration: AppAnimations.pageJump,
      curve: AppAnimations.pageJumpCurve,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemExtent: _itemExtent,
      itemCount: widget.events.length,
      itemBuilder: (context, index) {
        final Event event = widget.events[index];
        return Padding(
          padding: const EdgeInsetsDirectional.only(end: _gap),
          child: MapEventCard(
            event: event,
            address: widget.addresses[event.id],
            isAddressLoading: !widget.addresses.containsKey(event.id),
            isSelected: index == widget.selectedIndex,
            onTap: () => widget.onEventTap(event),
          ),
        );
      },
    );
  }
}
