class CoinbaseTicker {
  const CoinbaseTicker({
    required this.productId,
    required this.price,
    required this.open24h,
    required this.high24h,
    required this.low24h,
    required this.volume24h,
    required this.time,
  });

  final String productId;
  final double? price;
  final double? open24h;
  final double? high24h;
  final double? low24h;
  final double? volume24h;
  final DateTime? time;

  factory CoinbaseTicker.fromMap(Map<String, dynamic> map) {
    return CoinbaseTicker(
      productId: map['product_id']?.toString() ?? '',
      price: _double(map['price']),
      open24h: _double(map['open_24h']),
      high24h: _double(map['high_24h']),
      low24h: _double(map['low_24h']),
      volume24h: _double(map['volume_24h']),
      time: DateTime.tryParse(map['time']?.toString() ?? ''),
    );
  }

  static double? _double(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value?.toString() ?? '');
  }
}
