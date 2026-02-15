import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/car_model.dart';

class CarCard extends StatelessWidget {
  const CarCard({
    super.key,
    required this.car,
    required this.onTap,
  });

  final HotWheelsCar car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primaryImage = car.images.where((i) => i.isPrimary).firstOrNull ??
        car.images.firstOrNull;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: primaryImage != null
                  ? CachedNetworkImage(
                      imageUrl: primaryImage.url,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const _ImagePlaceholder(),
                      errorWidget: (_, __, ___) => const _ImagePlaceholder(),
                    )
                  : const _ImagePlaceholder(),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (car.series.isNotEmpty)
                    Text(
                      car.series,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (car.year != null)
                    Text(
                      '${car.year}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(Icons.directions_car, size: 48, color: Colors.grey),
      ),
    );
  }
}
