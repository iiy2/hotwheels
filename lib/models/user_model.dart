import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'car_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    @JsonKey(includeToJson: false) String? id,
    required String displayName,
    required String email,
    @Default('') String photoUrl,
    @Default(0) int totalCars,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser.fromJson({...data, 'id': doc.id});
  }
}
