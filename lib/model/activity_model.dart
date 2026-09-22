import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ActivityModel {
  final String id;
  final String userId;
  final ActivityType activityType;
  final double amount;
  final DateTime timestamp;
  ActivityModel({
    required this.id,
    required this.userId,
    required this.activityType,
    required this.amount,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'activityType': activityType.name,
      'amount': amount,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      activityType: ActivityType.values.firstWhere(
        (e) => e.name == map['activityType'],
      ),
      amount: map['amount'] as double,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityModel.fromJson(String source) =>
      ActivityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ActivityModel copyWith({
    String? id,
    String? userId,
    ActivityType? activityType,
    double? amount,
    DateTime? timestamp,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      activityType: activityType ?? this.activityType,
      amount: amount ?? this.amount,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

enum ActivityType { deposit, withdrawal, buy, sell }
