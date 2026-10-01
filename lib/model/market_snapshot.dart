import 'dart:convert';

class MarketSnapshot {
  const MarketSnapshot({
    this.id,
    this.symbol,
    this.name,
    this.imageUrl,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.fullyDilutedValuation,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.roi,
    this.lastUpdated,
    this.priceHistory,
    this.priceChangePercentage1h,
    this.priceChangePercentage7d,
    this.priceChangePercentage14d,
    this.priceChangePercentage30d,
    this.priceChangePercentage200d,
    this.priceChangePercentage1y,
    this.marketCapRankWithRehypothecated,
  });

  final String? id;
  final String? symbol;
  final String? name;
  final String? imageUrl;

  final double? currentPrice;
  final double? marketCap;
  final int? marketCapRank;
  final double? fullyDilutedValuation;
  final double? totalVolume;

  final double? high24h;
  final double? low24h;

  final double? priceChange24h;
  final double? priceChangePercentage24h;

  final double? marketCapChange24h;
  final double? marketCapChangePercentage24h;

  final double? circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;

  final double? ath;
  final double? athChangePercentage;
  final DateTime? athDate;

  final double? atl;
  final double? atlChangePercentage;
  final DateTime? atlDate;

  final MarketRoi? roi;

  final DateTime? lastUpdated;

  final List<double>? priceHistory;

  final double? priceChangePercentage1h;
  final double? priceChangePercentage7d;
  final double? priceChangePercentage14d;
  final double? priceChangePercentage30d;
  final double? priceChangePercentage200d;
  final double? priceChangePercentage1y;

  final int? marketCapRankWithRehypothecated;

  double? get priceUsd => currentPrice;

  MarketSnapshot copyWith({
    String? id,
    String? symbol,
    String? name,
    String? imageUrl,
    double? currentPrice,
    double? marketCap,
    int? marketCapRank,
    double? fullyDilutedValuation,
    double? totalVolume,
    double? high24h,
    double? low24h,
    double? priceChange24h,
    double? priceChangePercentage24h,
    double? marketCapChange24h,
    double? marketCapChangePercentage24h,
    double? circulatingSupply,
    double? totalSupply,
    double? maxSupply,
    double? ath,
    double? athChangePercentage,
    DateTime? athDate,
    double? atl,
    double? atlChangePercentage,
    DateTime? atlDate,
    MarketRoi? roi,
    DateTime? lastUpdated,
    List<double>? priceHistory,
    double? priceChangePercentage1h,
    double? priceChangePercentage7d,
    double? priceChangePercentage14d,
    double? priceChangePercentage30d,
    double? priceChangePercentage200d,
    double? priceChangePercentage1y,
    int? marketCapRankWithRehypothecated,
  }) {
    return MarketSnapshot(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      currentPrice: currentPrice ?? this.currentPrice,
      marketCap: marketCap ?? this.marketCap,
      marketCapRank: marketCapRank ?? this.marketCapRank,
      fullyDilutedValuation:
          fullyDilutedValuation ?? this.fullyDilutedValuation,
      totalVolume: totalVolume ?? this.totalVolume,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      priceChange24h: priceChange24h ?? this.priceChange24h,
      priceChangePercentage24h:
          priceChangePercentage24h ?? this.priceChangePercentage24h,
      marketCapChange24h: marketCapChange24h ?? this.marketCapChange24h,
      marketCapChangePercentage24h:
          marketCapChangePercentage24h ??
          this.marketCapChangePercentage24h,
      circulatingSupply: circulatingSupply ?? this.circulatingSupply,
      totalSupply: totalSupply ?? this.totalSupply,
      maxSupply: maxSupply ?? this.maxSupply,
      ath: ath ?? this.ath,
      athChangePercentage:
          athChangePercentage ?? this.athChangePercentage,
      athDate: athDate ?? this.athDate,
      atl: atl ?? this.atl,
      atlChangePercentage:
          atlChangePercentage ?? this.atlChangePercentage,
      atlDate: atlDate ?? this.atlDate,
      roi: roi ?? this.roi,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      priceHistory: priceHistory ?? this.priceHistory,
      priceChangePercentage1h:
          priceChangePercentage1h ?? this.priceChangePercentage1h,
      priceChangePercentage7d:
          priceChangePercentage7d ?? this.priceChangePercentage7d,
      priceChangePercentage14d:
          priceChangePercentage14d ?? this.priceChangePercentage14d,
      priceChangePercentage30d:
          priceChangePercentage30d ?? this.priceChangePercentage30d,
      priceChangePercentage200d:
          priceChangePercentage200d ?? this.priceChangePercentage200d,
      priceChangePercentage1y:
          priceChangePercentage1y ?? this.priceChangePercentage1y,
      marketCapRankWithRehypothecated:
          marketCapRankWithRehypothecated ??
          this.marketCapRankWithRehypothecated,
    );
  }

  factory MarketSnapshot.fromCoinGecko(Map<String, dynamic> json) {
    final sparkline = json['sparkline_in_7d'];
    final prices = sparkline is Map ? sparkline['price'] : null;

    return MarketSnapshot(
      id: json['id'] as String?,
      symbol: json['symbol'] as String?,
      name: json['name'] as String?,
      imageUrl: json['image'] as String?,
      currentPrice: _double(json['current_price']),
      marketCap: _double(json['market_cap']),
      marketCapRank: _int(json['market_cap_rank']),
      fullyDilutedValuation:
          _double(json['fully_diluted_valuation']),
      totalVolume: _double(json['total_volume']),
      high24h: _double(json['high_24h']),
      low24h: _double(json['low_24h']),
      priceChange24h: _double(json['price_change_24h']),
      priceChangePercentage24h:
          _double(json['price_change_percentage_24h']),
      marketCapChange24h:
          _double(json['market_cap_change_24h']),
      marketCapChangePercentage24h:
          _double(json['market_cap_change_percentage_24h']),
      circulatingSupply:
          _double(json['circulating_supply']),
      totalSupply: _double(json['total_supply']),
      maxSupply: _double(json['max_supply']),
      ath: _double(json['ath']),
      athChangePercentage:
          _double(json['ath_change_percentage']),
      athDate: _date(json['ath_date']),
      atl: _double(json['atl']),
      atlChangePercentage:
          _double(json['atl_change_percentage']),
      atlDate: _date(json['atl_date']),
      roi: json['roi'] is Map
          ? MarketRoi.fromMap(
              Map<String, dynamic>.from(json['roi']),
            )
          : null,
      lastUpdated: _date(json['last_updated']),
      priceHistory: prices is List
          ? prices
              .whereType<num>()
              .map((value) => value.toDouble())
              .toList(growable: false)
          : null,
      priceChangePercentage1h:
          _double(json['price_change_percentage_1h_in_currency']),
      priceChangePercentage7d:
          _double(json['price_change_percentage_7d_in_currency']),
      priceChangePercentage14d:
          _double(json['price_change_percentage_14d_in_currency']),
      priceChangePercentage30d:
          _double(json['price_change_percentage_30d_in_currency']),
      priceChangePercentage200d:
          _double(json['price_change_percentage_200d_in_currency']),
      priceChangePercentage1y:
          _double(json['price_change_percentage_1y_in_currency']),
      marketCapRankWithRehypothecated:
          _int(json['market_cap_rank_with_rehypothecated']),
    );
  }

  factory MarketSnapshot.fromMap(Map<String, dynamic> map) {
    return MarketSnapshot.fromCoinGecko(map);
  }

  factory MarketSnapshot.fromJson(String source) {
    return MarketSnapshot.fromMap(
      jsonDecode(source) as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': imageUrl,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
      'fully_diluted_valuation': fullyDilutedValuation,
      'total_volume': totalVolume,
      'high_24h': high24h,
      'low_24h': low24h,
      'price_change_24h': priceChange24h,
      'price_change_percentage_24h': priceChangePercentage24h,
      'market_cap_change_24h': marketCapChange24h,
      'market_cap_change_percentage_24h':
          marketCapChangePercentage24h,
      'circulating_supply': circulatingSupply,
      'total_supply': totalSupply,
      'max_supply': maxSupply,
      'ath': ath,
      'ath_change_percentage': athChangePercentage,
      'ath_date': athDate?.toIso8601String(),
      'atl': atl,
      'atl_change_percentage': atlChangePercentage,
      'atl_date': atlDate?.toIso8601String(),
      'roi': roi?.toMap(),
      'last_updated': lastUpdated?.toIso8601String(),
      'sparkline_in_7d': {
        'price': priceHistory,
      },
      'price_change_percentage_1h_in_currency':
          priceChangePercentage1h,
      'price_change_percentage_7d_in_currency':
          priceChangePercentage7d,
      'price_change_percentage_14d_in_currency':
          priceChangePercentage14d,
      'price_change_percentage_30d_in_currency':
          priceChangePercentage30d,
      'price_change_percentage_200d_in_currency':
          priceChangePercentage200d,
      'price_change_percentage_1y_in_currency':
          priceChangePercentage1y,
      'market_cap_rank_with_rehypothecated':
          marketCapRankWithRehypothecated,
    };
  }

  String toJson() => jsonEncode(toMap());

  static double? _double(dynamic value) {
    return value is num ? value.toDouble() : null;
  }

  static int? _int(dynamic value) {
    return value is num ? value.toInt() : null;
  }

  static DateTime? _date(dynamic value) {
    return value == null
        ? null
        : DateTime.tryParse(value.toString());
  }
}

class MarketRoi {
  const MarketRoi({
    this.times,
    this.currency,
    this.percentage,
  });

  final double? times;
  final String? currency;
  final double? percentage;

  MarketRoi copyWith({
    double? times,
    String? currency,
    double? percentage,
  }) {
    return MarketRoi(
      times: times ?? this.times,
      currency: currency ?? this.currency,
      percentage: percentage ?? this.percentage,
    );
  }

  factory MarketRoi.fromMap(Map<String, dynamic> map) {
    return MarketRoi(
      times: _double(map['times']),
      currency: map['currency'] as String?,
      percentage: _double(map['percentage']),
    );
  }

  factory MarketRoi.fromJson(String source) {
    return MarketRoi.fromMap(
      jsonDecode(source) as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'times': times,
      'currency': currency,
      'percentage': percentage,
    };
  }

  String toJson() => jsonEncode(toMap());

  static double? _double(dynamic value) {
    return value is num ? value.toDouble() : null;
  }
}