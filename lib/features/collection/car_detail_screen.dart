import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../core/errors/error_handler.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/car_providers.dart';
import '../../widgets/error_view.dart';

class CarDetailScreen extends ConsumerWidget {
  const CarDetailScreen({super.key, required this.carId});

  final String carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carAsync = ref.watch(carStreamProvider(carId));

    return carAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorView(
          message: 'Failed to load car details',
          onRetry: () => ref.invalidate(carStreamProvider(carId)),
        ),
      ),
      data: (car) {
        if (car == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Car not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(car.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => context.go('/collection/$carId/edit'),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _confirmDelete(context, ref),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image carousel
                if (car.images.isNotEmpty)
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      itemCount: car.images.length,
                      itemBuilder: (context, index) {
                        final image = car.images[index];
                        return GestureDetector(
                          onTap: () => _openGallery(context, car.images
                              .map((i) => i.url)
                              .toList(), index),
                          child: CachedNetworkImage(
                            imageUrl: image.url,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (_, __, ___) => const Center(
                              child: Icon(Icons.broken_image, size: 48),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  Container(
                    height: 200,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.directions_car,
                          size: 64, color: Colors.grey),
                    ),
                  ),

                // Image count indicator
                if (car.images.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${car.images.length} photos',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),

                // Metadata
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.name,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      if (car.series.isNotEmpty)
                        _DetailRow(label: 'Series', value: car.series),
                      if (car.year != null)
                        _DetailRow(label: 'Year', value: '${car.year}'),
                      if (car.notes.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text('Notes',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(car.notes),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Car'),
        content: const Text(
            'Are you sure you want to delete this car? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                final car =
                    await ref.read(carStreamProvider(carId).future);
                if (car != null) {
                  await ref
                      .read(deleteCarProvider.notifier)
                      .call(carId, car.images);
                }
                if (context.mounted) context.go('/collection');
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(ErrorHandler.userMessage(e))),
                  );
                }
              }
            },
            child: Text('Delete',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _openGallery(
      BuildContext context, List<String> imageUrls, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FullScreenGallery(
          imageUrls: imageUrls,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _FullScreenGallery extends StatelessWidget {
  const _FullScreenGallery({
    required this.imageUrls,
    required this.initialIndex,
  });

  final List<String> imageUrls;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: PhotoViewGallery.builder(
        itemCount: imageUrls.length,
        pageController: PageController(initialPage: initialIndex),
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(imageUrls[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        backgroundDecoration: const BoxDecoration(color: Colors.black),
      ),
    );
  }
}
