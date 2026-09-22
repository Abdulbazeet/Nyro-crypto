import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AssetsModel {
  final String id;
  final String userId;
  final String assetName;
  final double assetValue;
  final double assetQuantity;
  final String assetImageUrl;
  AssetsModel({
    required this.id,
    required this.userId,
    required this.assetName,
    required this.assetValue,
    required this.assetQuantity,
    required this.assetImageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'assetName': assetName,
      'assetValue': assetValue,
      'assetQuantity': assetQuantity,
      'assetImageUrl': assetImageUrl,
    };
  }

  factory AssetsModel.fromMap(Map<String, dynamic> map) {
    return AssetsModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      assetName: map['assetName'] as String,
      assetValue: map['assetValue'] as double,
      assetQuantity: map['assetQuantity'] as double,
      assetImageUrl: map['assetImageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetsModel.fromJson(String source) => AssetsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AssetsModel copyWith({
    String? id,
    String? userId,
    String? assetName,
    double? assetValue,
    double? assetQuantity,
    String? assetImageUrl,
  }) {
    return AssetsModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      assetName: assetName ?? this.assetName,
      assetValue: assetValue ?? this.assetValue,
      assetQuantity: assetQuantity ?? this.assetQuantity,
      assetImageUrl: assetImageUrl ?? this.assetImageUrl,
    );
  }
}
