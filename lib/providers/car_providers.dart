import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/car_model.dart';
import '../services/firestore_service.dart';
import '../services/storage_service.dart';
import 'auth_provider.dart';

part 'car_providers.g.dart';

@Riverpod(keepAlive: true)
FirestoreService firestoreService(Ref ref) {
  return FirestoreService();
}

@Riverpod(keepAlive: true)
StorageService storageService(Ref ref) {
  return StorageService();
}

String _requireUserId(Ref ref) {
  final user = ref.read(authStateProvider).valueOrNull;
  if (user == null) throw StateError('User not authenticated');
  return user.uid;
}

@riverpod
Stream<List<HotWheelsCar>> carsStream(Ref ref) {
  final userId = _requireUserId(ref);
  return ref.watch(firestoreServiceProvider).carsStream(userId);
}

@riverpod
Stream<HotWheelsCar?> carStream(Ref ref, String carId) {
  final userId = _requireUserId(ref);
  return ref.watch(firestoreServiceProvider).carStream(userId, carId);
}

@riverpod
class AddCar extends _$AddCar {
  @override
  FutureOr<String?> build() => null;

  Future<String?> call(HotWheelsCar car) async {
    final userId = _requireUserId(ref);
    state = const AsyncLoading();
    try {
      final carId = await ref.read(firestoreServiceProvider).addCar(userId, car);
      state = AsyncData(carId);
      return carId;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}

@riverpod
class UpdateCar extends _$UpdateCar {
  @override
  FutureOr<void> build() {}

  Future<void> call(String carId, Map<String, dynamic> data) async {
    final userId = _requireUserId(ref);
    state = const AsyncLoading();
    try {
      await ref.read(firestoreServiceProvider).updateCar(userId, carId, data);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}

@riverpod
class DeleteCar extends _$DeleteCar {
  @override
  FutureOr<void> build() {}

  Future<void> call(String carId, List<CarImage> images) async {
    final userId = _requireUserId(ref);
    state = const AsyncLoading();
    try {
      // Delete all images from storage first
      if (images.isNotEmpty) {
        await ref
            .read(storageServiceProvider)
            .deleteAllCarImages(userId: userId, carId: carId);
      }
      // Then delete the Firestore document
      await ref.read(firestoreServiceProvider).deleteCar(userId, carId);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
