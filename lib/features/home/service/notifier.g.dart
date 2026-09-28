// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(marketSnapshots)
final marketSnapshotsProvider = MarketSnapshotsProvider._();

final class MarketSnapshotsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MarketSnapshot>>,
          List<MarketSnapshot>,
          Stream<List<MarketSnapshot>>
        >
    with
        $FutureModifier<List<MarketSnapshot>>,
        $StreamProvider<List<MarketSnapshot>> {
  MarketSnapshotsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'marketSnapshotsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$marketSnapshotsHash();

  @$internal
  @override
  $StreamProviderElement<List<MarketSnapshot>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MarketSnapshot>> create(Ref ref) {
    return marketSnapshots(ref);
  }
}

String _$marketSnapshotsHash() => r'fd78e34259ac1fe27206cd0665f38dc477477ec4';
