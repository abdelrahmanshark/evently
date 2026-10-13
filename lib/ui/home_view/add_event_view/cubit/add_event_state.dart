import 'package:evently/models/app_failure.dart';
import 'package:flutter/material.dart';

class AddEventState {
  const AddEventState({
    this.selectedCategoryIndex = 0,
    this.date,
    this.time,
    this.isSaving = false,
    this.isSaved = false,
    this.failure,
  });

  /// Index in `EventCategory.all`.
  final int selectedCategoryIndex;
  final DateTime? date;
  final TimeOfDay? time;
  final bool isSaving;
  final bool isSaved;
  final AppFailure? failure;

  /// Returns a copy with the given values; [failure] is cleared unless passed.
  AddEventState copyWith({
    int? selectedCategoryIndex,
    DateTime? date,
    TimeOfDay? time,
    bool? isSaving,
    bool? isSaved,
    AppFailure? failure,
  }) {
    return AddEventState(
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      date: date ?? this.date,
      time: time ?? this.time,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      failure: failure,
    );
  }
}
