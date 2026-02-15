// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String?,
  displayName: json['displayName'] as String,
  email: json['email'] as String,
  photoUrl: json['photoUrl'] as String? ?? '',
  totalCars: (json['totalCars'] as num?)?.toInt() ?? 0,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'displayName': instance.displayName,
  'email': instance.email,
  'photoUrl': instance.photoUrl,
  'totalCars': instance.totalCars,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
