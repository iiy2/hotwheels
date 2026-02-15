import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/car_providers.dart';
import '../../widgets/error_view.dart';
import 'car_card.dart';

class CollectionListScreen extends ConsumerWidget {
  const CollectionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsAsync = ref.watch(carsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
      ),
      body: carsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          message: 'Failed to load collection',
          onRetry: () => ref.invalidate(carsStreamProvider),
        ),
        data: (cars) {
          if (cars.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.directions_car,
                      size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No cars yet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add your first Hot Wheels car',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              _StatsHeader(count: cars.length),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        AppConstants.collectionGridCrossAxisCount,
                    childAspectRatio: AppConstants.carCardAspectRatio,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return CarCard(
                      car: car,
                      onTap: () =>
                          context.go('/collection/${car.id}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/collection/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _StatsHeader extends StatelessWidget {
  const _StatsHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Text(
        '$count car${count == 1 ? '' : 's'} in collection',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
      ),
    );
  }
}
