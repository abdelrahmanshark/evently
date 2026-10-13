import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  const Event({
    this.id = '',
    required this.categoryId,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  });

  final String id;

  /// Category id such as `sport` or `birthday`.
  final String categoryId;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final double latitude;
  final double longitude;
  final bool isFavorite;

  /// Creates an [Event] from a Firestore document map.
  factory Event.fromFirestore(Map<String, dynamic> data) {
    return Event(
      id: data['id'] as String? ?? '',
      categoryId: data['eventName'] as String? ?? '',
      title: data['eventTitle'] as String? ?? '',
      description: data['eventDescrption'] as String? ?? '',
      date: (data['eventDate'] as Timestamp).toDate(),
      time: data['eventTime'] as String? ?? '',
      // Firestore may return whole numbers as int, so read them as num.
      latitude: (data['latitude'] as num? ?? 0).toDouble(),
      longitude: (data['longitude'] as num? ?? 0).toDouble(),
      isFavorite: data['isFavorite'] as bool? ?? false,
    );
  }

  /// Converts this event to a Firestore document map.
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'eventName': categoryId,
      'eventTitle': title,
      'eventDescrption': description,
      'eventDate': date,
      'eventTime': time,
      'latitude': latitude,
      'longitude': longitude,
      'isFavorite': isFavorite,
    };
  }

  /// Returns a copy of this event with a new [id].
  Event copyWith({String? id}) {
    return Event(
      id: id ?? this.id,
      categoryId: categoryId,
      title: title,
      description: description,
      date: date,
      time: time,
      latitude: latitude,
      longitude: longitude,
      isFavorite: isFavorite,
    );
  }
}
