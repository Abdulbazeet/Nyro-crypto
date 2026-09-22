import 'dart:convert';

class UserModels {
  final String? id;
  final String? email;
  final String? username;
  final double? portfolioValue;
  final String? currency;

  const UserModels({
    this.id,
    this.email,
    this.username,
    this.portfolioValue = 100000.0,
    this.currency = 'USD',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'portfolioValue': portfolioValue,
      'currency': currency,
    };
  }

  factory UserModels.fromMap(Map<String, dynamic> map) {
    return UserModels(
      id: map['id'] as String?,
      email: map['email'] as String?,
      username: map['username'] as String?,
      portfolioValue: (map['portfolioValue'] as num?)?.toDouble() ?? 100000.0,
      currency: map['currency'] as String? ?? 'USD',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModels.fromJson(String source) =>
      UserModels.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModels copyWith({
    String? id,
    String? email,
    String? username,
    double? portfolioValue,
    String? currency,
  }) {
    return UserModels(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      portfolioValue: portfolioValue ?? this.portfolioValue,
      currency: currency ?? this.currency,
    );
  }
}