import 'package:evently/domain/repositories/events_repository.dart';
import 'package:evently/models/app_failure.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/event_category.dart';
import 'package:evently/ui/home_view/add_event_view/cubit/add_event_state.dart';
import 'package:evently/utils/date_formats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

/// Creates a new event, or edits [eventToEdit] when it's passed.
@injectable
class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit(this._repository, @factoryParam this.eventToEdit)
    : _title = eventToEdit?.title ?? '',
      _description = eventToEdit?.description ?? '',
      super(_initialState(eventToEdit));

  final EventsRepository _repository;

  /// The event being edited, or null when creating a new one.
  final Event? eventToEdit;

  String _title;
  String _description;

  /// Whether this cubit edits an existing event instead of creating one.
  bool get isEditing => eventToEdit != null;

  /// Returns an empty state, or one filled from [event] when editing.
  static AddEventState _initialState(Event? event) {
    if (event == null) return const AddEventState();
    final int categoryIndex = EventCategory.all.indexWhere(
      (category) => category.id == event.categoryId,
    );
    return AddEventState(
      selectedCategoryIndex: categoryIndex == -1 ? 0 : categoryIndex,
      date: event.date,
      time: DateFormats.parseEventTime(event.time),
    );
  }

  /// Selects the category at [index] in `EventCategory.all`.
  void selectCategory(int index) {
    emit(state.copyWith(selectedCategoryIndex: index));
  }

  /// Stores the typed title.
  void onTitleChanged(String text) => _title = text.trim();

  /// Stores the typed description.
  void onDescriptionChanged(String text) => _description = text.trim();

  /// Sets the event date.
  void selectDate(DateTime date) => emit(state.copyWith(date: date));

  /// Sets the event time.
  void selectTime(TimeOfDay time) => emit(state.copyWith(time: time));

  /// Adds or updates the event at [location] for [userId].
  /// Date and time must already be selected.
  Future<void> saveEvent(String userId, LatLng location) async {
    if (state.isSaving || state.date == null || state.time == null) return;
    emit(state.copyWith(isSaving: true));
    final Event event = Event(
      id: eventToEdit?.id ?? '',
      categoryId: EventCategory.all[state.selectedCategoryIndex].id,
      title: _title,
      description: _description,
      date: state.date!,
      time: DateFormats.eventTime(state.time!),
      latitude: location.latitude,
      longitude: location.longitude,
      isFavorite: eventToEdit?.isFavorite ?? false,
    );
    try {
      if (isEditing) {
        await _repository.updateEvent(userId, event);
      } else {
        await _repository.addEvent(userId, event);
      }
      if (isClosed) return;
      emit(state.copyWith(isSaving: false, isSaved: true));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isSaving: false, failure: AppFailure.fromError(e)));
    }
  }
}
