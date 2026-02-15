// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CarImage _$CarImageFromJson(Map<String, dynamic> json) => _CarImage(
  id: json['id'] as String,
  url: json['url'] as String,
  storagePath: json['storagePath'] as String,
  isPrimary: json['isPrimary'] as bool? ?? false,
  embeddingRef: json['embeddingRef'] as String?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$CarImageToJson(_CarImage instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'storagePath': instance.storagePath,
  'isPrimary': instance.isPrimary,
  'embeddingRef': instance.embeddingRef,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};

_HotWheelsCar _$HotWheelsCarFromJson(Map<String, dynamic> json) =>
    _HotWheelsCar(
      id: json['id'] as String?,
      name: json['name'] as String,
      series: json['series'] as String? ?? '',
      year: (json['year'] as num?)?.toInt(),
      notes: json['notes'] as String? ?? '',
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => CarImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$HotWheelsCarToJson(_HotWheelsCar instance) =>
    <String, dynamic>{
      'name': instance.name,
      'series': instance.series,
      'year': instance.year,
      'notes': instance.notes,
      'images': instance.images,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
