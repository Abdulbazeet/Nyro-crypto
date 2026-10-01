class CoinbaseProduct {
  const CoinbaseProduct({
    required this.id,
    required this.baseCurrency,
    required this.quoteCurrency,
    required this.status,
  });

  final String id;
  final String baseCurrency;
  final String quoteCurrency;
  final String status;

  bool get isActiveUsdProduct {
    return quoteCurrency == 'USD' &&
        status == 'ONLINE' &&
        id.isNotEmpty &&
        baseCurrency.isNotEmpty;
  }

  factory CoinbaseProduct.fromMap(Map<String, dynamic> map) {
    return CoinbaseProduct(
      id: map['id']?.toString() ?? '',
      baseCurrency: map['base_currency']?.toString().toUpperCase() ?? '',
      quoteCurrency: map['quote_currency']?.toString().toUpperCase() ?? '',
      status: map['status']?.toString().toUpperCase() ?? '',
    );
  }
}
