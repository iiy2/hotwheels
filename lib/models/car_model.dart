import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'car_model.freezed.dart';
part 'car_model.g.dart';

@freezed
abstract class CarImage with _$CarImage {
  const factory CarImage({
    required String id,
    required String url,
    required String storagePath,
    @Default(false) bool isPrimary,
    String? embeddingRef,
    @TimestampConverter() DateTime? createdAt,
  }) = _CarImage;

  factory CarImage.fromJson(Map<String, dynamic> json) =>
      _$CarImageFromJson(json);
}

@freezed
abstract class HotWheelsCar with _$HotWheelsCar {
  const factory HotWheelsCar({
    @JsonKey(includeToJson: false) String? id,
    required String name,
    @Default('') String series,
    int? year,
    @Default('') String notes,
    @Default([]) List<CarImage> images,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _HotWheelsCar;

  factory HotWheelsCar.fromJson(Map<String, dynamic> json) =>
      _$HotWheelsCarFromJson(json);

  factory HotWheelsCar.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final imagesRaw = data['images'];
    debugPrint('[PARSE] doc=${doc.id} imagesType=${imagesRaw.runtimeType} imagesLen=${imagesRaw is List ? imagesRaw.length : "N/A"}');
    if (imagesRaw is List && imagesRaw.isNotEmpty) {
      debugPrint('[PARSE] first image type=${imagesRaw.first.runtimeType}');
      debugPrint('[PARSE] first image data=${imagesRaw.first}');
    }
    final car = HotWheelsCar.fromJson({...data, 'id': doc.id});
    debugPrint('[PARSE] doc=${doc.id} AFTER fromJson => images.length=${car.images.length}');
    if (car.images.isNotEmpty) {
      debugPrint('[PARSE] first parsed image url=${car.images.first.url}');
    }
    return car;
  }
}

class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.tryParse(json);
    return null;
  }

  @override
  Object? toJson(DateTime? date) {
    if (date == null) return null;
    return Timestamp.fromDate(date);
  }
}
