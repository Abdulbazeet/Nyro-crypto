import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nyro_cryto/features/market/widget/market_shimmer.dart';
import 'package:nyro_cryto/features/market/widget/market_tile.dart';
import 'package:nyro_cryto/model/market_snapshot.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketList extends StatefulWidget {
  const MarketList({
    required this.marketState,
    required this.onRefresh,
    super.key,
  });

  final AsyncValue<List<MarketSnapshot>> marketState;
  final Future<void> Function() onRefresh;

  @override
  State<MarketList> createState() => _MarketListState();
}

class _MarketListState extends State<MarketList> {
  static const _filters = ['All', 'Gainers', 'Losers', 'Owned'];

  final _searchController = TextEditingController();
  String _query = '';
  int _selectedFilter = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
            sliver: SliverToBoxAdapter(
              child: _MarketHeader(
                controller: _searchController,
                query: _query,
                filters: _filters,
                selectedFilter: _selectedFilter,
                onQueryChanged: (value) => setState(() => _query = value),
                onClearQuery: () {
                  _searchController.clear();
                  setState(() => _query = '');
                },
                onFilterChanged: (index) =>
                    setState(() => _selectedFilter = index),
              ),
            ),
          ),
          ..._buildMarketContent(theme),
        ],
      ),
    );
  }

  List<Widget> _buildMarketContent(ThemeData theme) {
    return widget.marketState.when(
      loading: () => const [SliverToBoxAdapter(child: MarketShimmer())],
      error: (error, stackTrace) => [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Market data unavailable',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
      data: (markets) {
        final visibleMarkets = _filterMarkets(markets);

        if (visibleMarkets.isEmpty) {
          return [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  _selectedFilter == 3
                      ? 'No owned markets yet'
                      : 'No markets found',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ),
          ];
        }

        return [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            sliver: SliverList.builder(
              itemCount: visibleMarkets.length,
              itemBuilder: (context, index) {
                final market = visibleMarkets[index];
                return MarketTile(
                  market: market,
                  onTap: () => context.push('/home-market', extra: market),
                );
              },
            ),
          ),
        ];
      },
    );
  }

  List<MarketSnapshot> _filterMarkets(List<MarketSnapshot> markets) {
    final query = _query.trim().toLowerCase();

    return markets
        .where((market) {
          final matchesQuery =
              query.isEmpty ||
              (market.name?.toLowerCase().contains(query) ?? false) ||
              (market.symbol?.toLowerCase().contains(query) ?? false);

          final change = market.priceChangePercentage24h ?? 0;
          final matchesFilter = switch (_selectedFilter) {
            1 => change > 0,
            2 => change < 0,
            3 => false,
            _ => true,
          };

          return matchesQuery && matchesFilter;
        })
        .toList(growable: false);
  }
}

class _MarketHeader extends StatelessWidget {
  const _MarketHeader({
    required this.controller,
    required this.query,
    required this.filters,
    required this.selectedFilter,
    required this.onQueryChanged,
    required this.onClearQuery,
    required this.onFilterChanged,
  });

  final TextEditingController controller;
  final String query;
  final List<String> filters;
  final int selectedFilter;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onClearQuery;
  final ValueChanged<int> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Market', style: theme.textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text('Prices update as you trade', style: theme.textTheme.bodySmall),
        const SizedBox(height: 20),
        TextField(
          controller: controller,
          onChanged: onQueryChanged,
          decoration: InputDecoration(
            hintText: 'Search coin or symbol',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: query.isEmpty
                ? null
                : IconButton(
                    tooltip: 'Clear search',
                    onPressed: onClearQuery,
                    icon: const Icon(Icons.close),
                  ),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return ChoiceChip(
                label: Text(filters[index]),
                selected: selectedFilter == index,
                onSelected: (_) => onFilterChanged(index),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
