import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/car_model.dart';
import '../../providers/car_providers.dart';
import '../../features/collection/car_card.dart';
import '../../core/constants/app_constants.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<HotWheelsCar> _filter(List<HotWheelsCar> cars) {
    if (_query.isEmpty) return [];
    final q = _query.toLowerCase();
    return cars.where((car) {
      return car.name.toLowerCase().contains(q) ||
          car.series.toLowerCase().contains(q) ||
          (car.year?.toString().contains(q) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final carsAsync = ref.watch(carsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search by name, series, or year...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
              ),
              onChanged: (value) => setState(() => _query = value.trim()),
              textInputAction: TextInputAction.search,
            ),
          ),
          Expanded(
            child: carsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, __) =>
                  const Center(child: Text('Failed to load collection')),
              data: (cars) {
                if (_query.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search,
                            size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          'Type to search your collection',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  );
                }

                final results = _filter(cars);

                if (results.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off,
                            size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          'No cars matching "$_query"',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        AppConstants.collectionGridCrossAxisCount,
                    childAspectRatio: AppConstants.carCardAspectRatio,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final car = results[index];
                    return CarCard(
                      car: car,
                      onTap: () => context.go('/collection/${car.id}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
