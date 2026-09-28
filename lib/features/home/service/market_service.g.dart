// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(marketService)
final marketServiceProvider = MarketServiceProvider._();

final class MarketServiceProvider
    extends $FunctionalProvider<MarketService, MarketService, MarketService>
    with $Provider<MarketService> {
  MarketServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'marketServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$marketServiceHash();

  @$internal
  @override
  $ProviderElement<MarketService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MarketService create(Ref ref) {
    return marketService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MarketService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MarketService>(value),
    );
  }
}

String _$marketServiceHash() => r'ae085db9a81a28f775fe2d606e7299f16c8b885f';
