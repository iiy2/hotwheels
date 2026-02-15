// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'car_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CarImage {

 String get id; String get url; String get storagePath; bool get isPrimary; String? get embeddingRef;@TimestampConverter() DateTime? get createdAt;
/// Create a copy of CarImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarImageCopyWith<CarImage> get copyWith => _$CarImageCopyWithImpl<CarImage>(this as CarImage, _$identity);

  /// Serializes this CarImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarImage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.embeddingRef, embeddingRef) || other.embeddingRef == embeddingRef)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,storagePath,isPrimary,embeddingRef,createdAt);

@override
String toString() {
  return 'CarImage(id: $id, url: $url, storagePath: $storagePath, isPrimary: $isPrimary, embeddingRef: $embeddingRef, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CarImageCopyWith<$Res>  {
  factory $CarImageCopyWith(CarImage value, $Res Function(CarImage) _then) = _$CarImageCopyWithImpl;
@useResult
$Res call({
 String id, String url, String storagePath, bool isPrimary, String? embeddingRef,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class _$CarImageCopyWithImpl<$Res>
    implements $CarImageCopyWith<$Res> {
  _$CarImageCopyWithImpl(this._self, this._then);

  final CarImage _self;
  final $Res Function(CarImage) _then;

/// Create a copy of CarImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? storagePath = null,Object? isPrimary = null,Object? embeddingRef = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,embeddingRef: freezed == embeddingRef ? _self.embeddingRef : embeddingRef // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CarImage].
extension CarImagePatterns on CarImage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarImage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarImage value)  $default,){
final _that = this;
switch (_that) {
case _CarImage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarImage value)?  $default,){
final _that = this;
switch (_that) {
case _CarImage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String url,  String storagePath,  bool isPrimary,  String? embeddingRef, @TimestampConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarImage() when $default != null:
return $default(_that.id,_that.url,_that.storagePath,_that.isPrimary,_that.embeddingRef,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String url,  String storagePath,  bool isPrimary,  String? embeddingRef, @TimestampConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CarImage():
return $default(_that.id,_that.url,_that.storagePath,_that.isPrimary,_that.embeddingRef,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String url,  String storagePath,  bool isPrimary,  String? embeddingRef, @TimestampConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CarImage() when $default != null:
return $default(_that.id,_that.url,_that.storagePath,_that.isPrimary,_that.embeddingRef,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CarImage implements CarImage {
  const _CarImage({required this.id, required this.url, required this.storagePath, this.isPrimary = false, this.embeddingRef, @TimestampConverter() this.createdAt});
  factory _CarImage.fromJson(Map<String, dynamic> json) => _$CarImageFromJson(json);

@override final  String id;
@override final  String url;
@override final  String storagePath;
@override@JsonKey() final  bool isPrimary;
@override final  String? embeddingRef;
@override@TimestampConverter() final  DateTime? createdAt;

/// Create a copy of CarImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarImageCopyWith<_CarImage> get copyWith => __$CarImageCopyWithImpl<_CarImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CarImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarImage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.embeddingRef, embeddingRef) || other.embeddingRef == embeddingRef)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,storagePath,isPrimary,embeddingRef,createdAt);

@override
String toString() {
  return 'CarImage(id: $id, url: $url, storagePath: $storagePath, isPrimary: $isPrimary, embeddingRef: $embeddingRef, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CarImageCopyWith<$Res> implements $CarImageCopyWith<$Res> {
  factory _$CarImageCopyWith(_CarImage value, $Res Function(_CarImage) _then) = __$CarImageCopyWithImpl;
@override @useResult
$Res call({
 String id, String url, String storagePath, bool isPrimary, String? embeddingRef,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class __$CarImageCopyWithImpl<$Res>
    implements _$CarImageCopyWith<$Res> {
  __$CarImageCopyWithImpl(this._self, this._then);

  final _CarImage _self;
  final $Res Function(_CarImage) _then;

/// Create a copy of CarImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? storagePath = null,Object? isPrimary = null,Object? embeddingRef = freezed,Object? createdAt = freezed,}) {
  return _then(_CarImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,embeddingRef: freezed == embeddingRef ? _self.embeddingRef : embeddingRef // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$HotWheelsCar {

@JsonKey(includeToJson: false) String? get id; String get name; String get series; int? get year; String get notes; List<CarImage> get images;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt;
/// Create a copy of HotWheelsCar
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HotWheelsCarCopyWith<HotWheelsCar> get copyWith => _$HotWheelsCarCopyWithImpl<HotWheelsCar>(this as HotWheelsCar, _$identity);

  /// Serializes this HotWheelsCar to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HotWheelsCar&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.series, series) || other.series == series)&&(identical(other.year, year) || other.year == year)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,series,year,notes,const DeepCollectionEquality().hash(images),createdAt,updatedAt);

@override
String toString() {
  return 'HotWheelsCar(id: $id, name: $name, series: $series, year: $year, notes: $notes, images: $images, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $HotWheelsCarCopyWith<$Res>  {
  factory $HotWheelsCarCopyWith(HotWheelsCar value, $Res Function(HotWheelsCar) _then) = _$HotWheelsCarCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String? id, String name, String series, int? year, String notes, List<CarImage> images,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$HotWheelsCarCopyWithImpl<$Res>
    implements $HotWheelsCarCopyWith<$Res> {
  _$HotWheelsCarCopyWithImpl(this._self, this._then);

  final HotWheelsCar _self;
  final $Res Function(HotWheelsCar) _then;

/// Create a copy of HotWheelsCar
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? series = null,Object? year = freezed,Object? notes = null,Object? images = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<CarImage>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [HotWheelsCar].
extension HotWheelsCarPatterns on HotWheelsCar {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HotWheelsCar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HotWheelsCar() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HotWheelsCar value)  $default,){
final _that = this;
switch (_that) {
case _HotWheelsCar():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HotWheelsCar value)?  $default,){
final _that = this;
switch (_that) {
case _HotWheelsCar() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String? id,  String name,  String series,  int? year,  String notes,  List<CarImage> images, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HotWheelsCar() when $default != null:
return $default(_that.id,_that.name,_that.series,_that.year,_that.notes,_that.images,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String? id,  String name,  String series,  int? year,  String notes,  List<CarImage> images, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _HotWheelsCar():
return $default(_that.id,_that.name,_that.series,_that.year,_that.notes,_that.images,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String? id,  String name,  String series,  int? year,  String notes,  List<CarImage> images, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _HotWheelsCar() when $default != null:
return $default(_that.id,_that.name,_that.series,_that.year,_that.notes,_that.images,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HotWheelsCar implements HotWheelsCar {
  const _HotWheelsCar({@JsonKey(includeToJson: false) this.id, required this.name, this.series = '', this.year, this.notes = '', final  List<CarImage> images = const [], @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt}): _images = images;
  factory _HotWheelsCar.fromJson(Map<String, dynamic> json) => _$HotWheelsCarFromJson(json);

@override@JsonKey(includeToJson: false) final  String? id;
@override final  String name;
@override@JsonKey() final  String series;
@override final  int? year;
@override@JsonKey() final  String notes;
 final  List<CarImage> _images;
@override@JsonKey() List<CarImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;

/// Create a copy of HotWheelsCar
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HotWheelsCarCopyWith<_HotWheelsCar> get copyWith => __$HotWheelsCarCopyWithImpl<_HotWheelsCar>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HotWheelsCarToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HotWheelsCar&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.series, series) || other.series == series)&&(identical(other.year, year) || other.year == year)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,series,year,notes,const DeepCollectionEquality().hash(_images),createdAt,updatedAt);

@override
String toString() {
  return 'HotWheelsCar(id: $id, name: $name, series: $series, year: $year, notes: $notes, images: $images, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$HotWheelsCarCopyWith<$Res> implements $HotWheelsCarCopyWith<$Res> {
  factory _$HotWheelsCarCopyWith(_HotWheelsCar value, $Res Function(_HotWheelsCar) _then) = __$HotWheelsCarCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String? id, String name, String series, int? year, String notes, List<CarImage> images,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$HotWheelsCarCopyWithImpl<$Res>
    implements _$HotWheelsCarCopyWith<$Res> {
  __$HotWheelsCarCopyWithImpl(this._self, this._then);

  final _HotWheelsCar _self;
  final $Res Function(_HotWheelsCar) _then;

/// Create a copy of HotWheelsCar
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? series = null,Object? year = freezed,Object? notes = null,Object? images = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_HotWheelsCar(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<CarImage>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
