class UserModels {
  final String id;
  final String email;
  final String username;

  const UserModels({
    required this.id,
    required this.email,
    required this.username,
  });

  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
    };
  }

  UserModels copyWith({
    String? id,
    String? email,
    String? username,
  }) {
    return UserModels(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
    );
  }

  @override
  String toString() {
    return 'UserModels('
        'id: $id, '
        'email: $email, '
        'username: $username'
        ')';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModels &&
        other.id == id &&
        other.email == email &&
        other.username == username;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      email,
      username,
    );
  }
}
