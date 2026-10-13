import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormats {
  /// Formats an event date as `dd/MM/yyyy`.
  static String eventDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Formats an event time as `hh:mm a`.
  static String eventTime(TimeOfDay time) {
    final DateTime dateTime = DateTime(2000, 1, 1, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dateTime);
  }

  /// Reads a time saved by [eventTime], or returns null when it can't be read.
  static TimeOfDay? parseEventTime(String time) {
    try {
      final DateTime dateTime = DateFormat('hh:mm a').parse(time);
      return TimeOfDay.fromDateTime(dateTime);
    } on FormatException {
      return null;
    }
  }

  /// Formats a date with the full month name (e.g. `21 November 2024`).
  static String longDate(DateTime date) {
    return DateFormat('d MMMM yyyy').format(date);
  }

  /// Formats a date as a short month name (e.g. `Jan`).
  static String shortMonth(DateTime date) {
    return DateFormat('MMM').format(date);
  }
}
