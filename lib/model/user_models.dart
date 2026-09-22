// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModels {
  final String id;
  final String email;
  final String username;
  final double portfolioValue;
  final String currency;

  const UserModels({
    required this.id,
    required this.email,
    required this.username,
    required this.portfolioValue,
    required this.currency,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'portfolioValue': portfolioValue,
      'currency': currency,
    };
  }

  factory UserModels.fromMap(Map<String, dynamic> map) {
    return UserModels(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      portfolioValue: map['portfolioValue'] as double,
      currency: map['currency'] as String,
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
