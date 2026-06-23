import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants/firestore_paths.dart';
import '../core/errors/app_exception.dart';
import '../models/car_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  // ── User ──────────────────────────────────────────────────────────

  Stream<AppUser?> userStream(String userId) {
    return _firestore.doc(FirestorePaths.user(userId)).snapshots().map((doc) {
      if (!doc.exists) return null;
      return AppUser.fromFirestore(doc);
    });
  }

  Future<void> updateUserProfile(
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.doc(FirestorePaths.user(userId)).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw FirestoreException('Failed to update profile', e);
    }
  }

  // ── Cars ──────────────────────────────────────────────────────────

  Stream<List<HotWheelsCar>> carsStream(String userId) {
    return _firestore
        .collection(FirestorePaths.cars(userId))
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map(HotWheelsCar.fromFirestore).toList());
  }

  Stream<HotWheelsCar?> carStream(String userId, String carId) {
    return _firestore
        .doc(FirestorePaths.car(userId, carId))
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      return HotWheelsCar.fromFirestore(doc);
    });
  }

  Future<String> addCar(String userId, HotWheelsCar car) async {
    try {
      final data = car.toJson();
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();

      final docRef =
          await _firestore.collection(FirestorePaths.cars(userId)).add(data);

      await _incrementCarCount(userId, 1);
      return docRef.id;
    } catch (e) {
      throw FirestoreException('Failed to add car', e);
    }
  }

  Future<void> updateCar(
    String userId,
    String carId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.doc(FirestorePaths.car(userId, carId)).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw FirestoreException('Failed to update car', e);
    }
  }

  Future<void> deleteCar(String userId, String carId) async {
    try {
      await _firestore.doc(FirestorePaths.car(userId, carId)).delete();
      await _incrementCarCount(userId, -1);
    } catch (e) {
      throw FirestoreException('Failed to delete car', e);
    }
  }

  Future<void> _incrementCarCount(String userId, int delta) async {
    await _firestore.doc(FirestorePaths.user(userId)).update({
      'totalCars': FieldValue.increment(delta),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
