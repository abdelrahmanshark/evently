class MyUser {
  const MyUser({required this.id, required this.name, required this.email});

  final String id;
  final String name;
  final String email;

  /// Creates a [MyUser] from a Firestore document map.
  factory MyUser.fromFirestore(Map<String, dynamic> data) {
    return MyUser(
      id: data['id'] as String? ?? '',
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
    );
  }

  /// Converts this user to a Firestore document map.
  Map<String, dynamic> toFirestore() {
    return {'id': id, 'name': name, 'email': email};
  }
}
