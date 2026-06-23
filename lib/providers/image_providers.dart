import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/car_model.dart';
import '../core/utils/image_utils.dart';
import 'car_providers.dart';
import 'auth_provider.dart';

part 'image_providers.g.dart';

@riverpod
class UploadCarImage extends _$UploadCarImage {
  @override
  FutureOr<CarImage?> build() => null;

  Future<CarImage?> call({
    required String carId,
    required XFile file,
    bool isPrimary = false,
  }) async {
    final user = ref.read(authStateProvider).valueOrNull;
    if (user == null) throw StateError('User not authenticated');
    final userId = user.uid;

    state = const AsyncLoading();
    try {
      final imageId = ImageUtils.generateImageId();
      final storagePath =
          'users/$userId/cars/$carId/$imageId.jpg';

      final Uint8List bytes = await file.readAsBytes();
      final contentType = file.mimeType ?? ImageUtils.mimeTypeFromExtension(file.name);

      final url = await ref.read(storageServiceProvider).uploadCarImage(
            userId: userId,
            carId: carId,
            imageId: imageId,
            bytes: bytes,
            contentType: contentType,
          );

      final image = CarImage(
        id: imageId,
        url: url,
        storagePath: storagePath,
        isPrimary: isPrimary,
        createdAt: DateTime.now(),
      );

      // Fetch current car to append the image
      final carAsync = await ref.read(carStreamProvider(carId).future);
      if (carAsync != null) {
        final updatedImages = [...carAsync.images, image];
        await ref.read(firestoreServiceProvider).updateCar(
          userId,
          carId,
          {'images': updatedImages.map((i) => i.toJson()).toList()},
        );
      }

      state = AsyncData(image);
      return image;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}

@riverpod
class DeleteCarImage extends _$DeleteCarImage {
  @override
  FutureOr<void> build() {}

  Future<void> call({
    required String carId,
    required CarImage image,
  }) async {
    final user = ref.read(authStateProvider).valueOrNull;
    if (user == null) throw StateError('User not authenticated');
    final userId = user.uid;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(storageServiceProvider).deleteCarImage(
            userId: userId,
            carId: carId,
            imageId: image.id,
          );

      final carAsync = await ref.read(carStreamProvider(carId).future);
      if (carAsync != null) {
        final updatedImages =
            carAsync.images.where((i) => i.id != image.id).toList();
        await ref.read(firestoreServiceProvider).updateCar(
          userId,
          carId,
          {'images': updatedImages.map((i) => i.toJson()).toList()},
        );
      }
    });
  }
}
