import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import '../core/constants/storage_paths.dart';
import '../core/errors/app_exception.dart';

class StorageService {
  StorageService({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;

  Future<String> uploadCarImage({
    required String userId,
    required String carId,
    required String imageId,
    required Uint8List bytes,
    String contentType = 'image/jpeg',
  }) async {
    try {
      final path = StoragePaths.carImage(userId, carId, imageId);
      final ref = _storage.ref(path);
      await ref.putData(bytes, SettableMetadata(contentType: contentType));
      return await ref.getDownloadURL();
    } catch (e) {
      throw StorageException('Failed to upload image', e);
    }
  }

  Future<void> deleteCarImage({
    required String userId,
    required String carId,
    required String imageId,
  }) async {
    try {
      final path = StoragePaths.carImage(userId, carId, imageId);
      await _storage.ref(path).delete();
    } catch (e) {
      throw StorageException('Failed to delete image', e);
    }
  }

  Future<void> deleteAllCarImages({
    required String userId,
    required String carId,
  }) async {
    try {
      final prefix = 'users/$userId/cars/$carId/';
      final result = await _storage.ref(prefix).listAll();
      await Future.wait(result.items.map((ref) => ref.delete()));
    } catch (e) {
      throw StorageException('Failed to delete car images', e);
    }
  }
}
