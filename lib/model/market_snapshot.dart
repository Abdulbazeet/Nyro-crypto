import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MarketSnapshot {
  final String id;
  final String symbol;
  final String name;
  final String imageUrl;
  final double priceUsd;
  final double priceChangePercentage24h;
  final List<double> priceHistory;
  final DateTime updatedAt;

  const MarketSnapshot({
    required this.id,
    required this.symbol,
    required this.name,
    required this.imageUrl,
    required this.priceUsd,
    required this.priceChangePercentage24h,
    this.priceHistory = const [],
    required this.updatedAt,
  });

  MarketSnapshot copyWith({
    String? id,
    String? symbol,
    String? name,
    String? imageUrl,
    double? priceUsd,
    double? priceChangePercentage24h,
    List<double>? priceHistory,
    DateTime? updatedAt,
  }) {
    return MarketSnapshot(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      priceUsd: priceUsd ?? this.priceUsd,
      priceChangePercentage24h:
          priceChangePercentage24h ?? this.priceChangePercentage24h,
      priceHistory: priceHistory ?? this.priceHistory,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'symbol': symbol,
      'name': name,
      'imageUrl': imageUrl,
      'priceUsd': priceUsd,
      'priceChangePercentage24h': priceChangePercentage24h,
      'priceHistory': priceHistory,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory MarketSnapshot.fromMap(Map<String, dynamic> map) {
    return MarketSnapshot(
      id: map['id'] as String,
      symbol: map['symbol'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      priceUsd: map['priceUsd'] as double,
      priceChangePercentage24h: map['priceChangePercentage24h'] as double,
      priceHistory: (map['priceHistory'] as List<dynamic>? ?? const [])
          .map((value) => (value as num).toDouble())
          .toList(growable: false),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MarketSnapshot.fromJson(String source) =>
      MarketSnapshot.fromMap(json.decode(source) as Map<String, dynamic>);
}
