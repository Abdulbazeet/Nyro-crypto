// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(marketDataService)
final marketDataServiceProvider = MarketDataServiceProvider._();

final class MarketDataServiceProvider
    extends
        $FunctionalProvider<
          MarketDataService,
          MarketDataService,
          MarketDataService
        >
    with $Provider<MarketDataService> {
  MarketDataServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'marketDataServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$marketDataServiceHash();

  @$internal
  @override
  $ProviderElement<MarketDataService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MarketDataService create(Ref ref) {
    return marketDataService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MarketDataService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MarketDataService>(value),
    );
  }
}

String _$marketDataServiceHash() => r'6687692e7670708ad30529dc0fb3ac42421305ce';

@ProviderFor(marketMarkets)
final marketMarketsProvider = MarketMarketsProvider._();

final class MarketMarketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MarketSnapshot>>,
          List<MarketSnapshot>,
          Stream<List<MarketSnapshot>>
        >
    with
        $FutureModifier<List<MarketSnapshot>>,
        $StreamProvider<List<MarketSnapshot>> {
  MarketMarketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'marketMarketsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$marketMarketsHash();

  @$internal
  @override
  $StreamProviderElement<List<MarketSnapshot>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MarketSnapshot>> create(Ref ref) {
    return marketMarkets(ref);
  }
}

String _$marketMarketsHash() => r'2b2ce5b52a817bd4816c2249e6e3ecc5438e7ee3';
