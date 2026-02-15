// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recognition_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecognitionResult {

 String? get modelName; String? get series; double get confidence; List<String> get labels; List<SimilarMatch> get similarMatches;
/// Create a copy of RecognitionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecognitionResultCopyWith<RecognitionResult> get copyWith => _$RecognitionResultCopyWithImpl<RecognitionResult>(this as RecognitionResult, _$identity);

  /// Serializes this RecognitionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecognitionResult&&(identical(other.modelName, modelName) || other.modelName == modelName)&&(identical(other.series, series) || other.series == series)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other.labels, labels)&&const DeepCollectionEquality().equals(other.similarMatches, similarMatches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelName,series,confidence,const DeepCollectionEquality().hash(labels),const DeepCollectionEquality().hash(similarMatches));

@override
String toString() {
  return 'RecognitionResult(modelName: $modelName, series: $series, confidence: $confidence, labels: $labels, similarMatches: $similarMatches)';
}


}

/// @nodoc
abstract mixin class $RecognitionResultCopyWith<$Res>  {
  factory $RecognitionResultCopyWith(RecognitionResult value, $Res Function(RecognitionResult) _then) = _$RecognitionResultCopyWithImpl;
@useResult
$Res call({
 String? modelName, String? series, double confidence, List<String> labels, List<SimilarMatch> similarMatches
});




}
/// @nodoc
class _$RecognitionResultCopyWithImpl<$Res>
    implements $RecognitionResultCopyWith<$Res> {
  _$RecognitionResultCopyWithImpl(this._self, this._then);

  final RecognitionResult _self;
  final $Res Function(RecognitionResult) _then;

/// Create a copy of RecognitionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modelName = freezed,Object? series = freezed,Object? confidence = null,Object? labels = null,Object? similarMatches = null,}) {
  return _then(_self.copyWith(
modelName: freezed == modelName ? _self.modelName : modelName // ignore: cast_nullable_to_non_nullable
as String?,series: freezed == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String?,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,similarMatches: null == similarMatches ? _self.similarMatches : similarMatches // ignore: cast_nullable_to_non_nullable
as List<SimilarMatch>,
  ));
}

}


/// Adds pattern-matching-related methods to [RecognitionResult].
extension RecognitionResultPatterns on RecognitionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecognitionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecognitionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecognitionResult value)  $default,){
final _that = this;
switch (_that) {
case _RecognitionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecognitionResult value)?  $default,){
final _that = this;
switch (_that) {
case _RecognitionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? modelName,  String? series,  double confidence,  List<String> labels,  List<SimilarMatch> similarMatches)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecognitionResult() when $default != null:
return $default(_that.modelName,_that.series,_that.confidence,_that.labels,_that.similarMatches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? modelName,  String? series,  double confidence,  List<String> labels,  List<SimilarMatch> similarMatches)  $default,) {final _that = this;
switch (_that) {
case _RecognitionResult():
return $default(_that.modelName,_that.series,_that.confidence,_that.labels,_that.similarMatches);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? modelName,  String? series,  double confidence,  List<String> labels,  List<SimilarMatch> similarMatches)?  $default,) {final _that = this;
switch (_that) {
case _RecognitionResult() when $default != null:
return $default(_that.modelName,_that.series,_that.confidence,_that.labels,_that.similarMatches);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecognitionResult implements RecognitionResult {
  const _RecognitionResult({this.modelName, this.series, this.confidence = 0.0, final  List<String> labels = const [], final  List<SimilarMatch> similarMatches = const []}): _labels = labels,_similarMatches = similarMatches;
  factory _RecognitionResult.fromJson(Map<String, dynamic> json) => _$RecognitionResultFromJson(json);

@override final  String? modelName;
@override final  String? series;
@override@JsonKey() final  double confidence;
 final  List<String> _labels;
@override@JsonKey() List<String> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

 final  List<SimilarMatch> _similarMatches;
@override@JsonKey() List<SimilarMatch> get similarMatches {
  if (_similarMatches is EqualUnmodifiableListView) return _similarMatches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_similarMatches);
}


/// Create a copy of RecognitionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecognitionResultCopyWith<_RecognitionResult> get copyWith => __$RecognitionResultCopyWithImpl<_RecognitionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecognitionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecognitionResult&&(identical(other.modelName, modelName) || other.modelName == modelName)&&(identical(other.series, series) || other.series == series)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other._labels, _labels)&&const DeepCollectionEquality().equals(other._similarMatches, _similarMatches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelName,series,confidence,const DeepCollectionEquality().hash(_labels),const DeepCollectionEquality().hash(_similarMatches));

@override
String toString() {
  return 'RecognitionResult(modelName: $modelName, series: $series, confidence: $confidence, labels: $labels, similarMatches: $similarMatches)';
}


}

/// @nodoc
abstract mixin class _$RecognitionResultCopyWith<$Res> implements $RecognitionResultCopyWith<$Res> {
  factory _$RecognitionResultCopyWith(_RecognitionResult value, $Res Function(_RecognitionResult) _then) = __$RecognitionResultCopyWithImpl;
@override @useResult
$Res call({
 String? modelName, String? series, double confidence, List<String> labels, List<SimilarMatch> similarMatches
});




}
/// @nodoc
class __$RecognitionResultCopyWithImpl<$Res>
    implements _$RecognitionResultCopyWith<$Res> {
  __$RecognitionResultCopyWithImpl(this._self, this._then);

  final _RecognitionResult _self;
  final $Res Function(_RecognitionResult) _then;

/// Create a copy of RecognitionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modelName = freezed,Object? series = freezed,Object? confidence = null,Object? labels = null,Object? similarMatches = null,}) {
  return _then(_RecognitionResult(
modelName: freezed == modelName ? _self.modelName : modelName // ignore: cast_nullable_to_non_nullable
as String?,series: freezed == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String?,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,similarMatches: null == similarMatches ? _self._similarMatches : similarMatches // ignore: cast_nullable_to_non_nullable
as List<SimilarMatch>,
  ));
}


}


/// @nodoc
mixin _$SimilarMatch {

 String get carId; String get carName; String get imageUrl; double get similarity;
/// Create a copy of SimilarMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimilarMatchCopyWith<SimilarMatch> get copyWith => _$SimilarMatchCopyWithImpl<SimilarMatch>(this as SimilarMatch, _$identity);

  /// Serializes this SimilarMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimilarMatch&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.carName, carName) || other.carName == carName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.similarity, similarity) || other.similarity == similarity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,carId,carName,imageUrl,similarity);

@override
String toString() {
  return 'SimilarMatch(carId: $carId, carName: $carName, imageUrl: $imageUrl, similarity: $similarity)';
}


}

/// @nodoc
abstract mixin class $SimilarMatchCopyWith<$Res>  {
  factory $SimilarMatchCopyWith(SimilarMatch value, $Res Function(SimilarMatch) _then) = _$SimilarMatchCopyWithImpl;
@useResult
$Res call({
 String carId, String carName, String imageUrl, double similarity
});




}
/// @nodoc
class _$SimilarMatchCopyWithImpl<$Res>
    implements $SimilarMatchCopyWith<$Res> {
  _$SimilarMatchCopyWithImpl(this._self, this._then);

  final SimilarMatch _self;
  final $Res Function(SimilarMatch) _then;

/// Create a copy of SimilarMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? carId = null,Object? carName = null,Object? imageUrl = null,Object? similarity = null,}) {
  return _then(_self.copyWith(
carId: null == carId ? _self.carId : carId // ignore: cast_nullable_to_non_nullable
as String,carName: null == carName ? _self.carName : carName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SimilarMatch].
extension SimilarMatchPatterns on SimilarMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimilarMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimilarMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimilarMatch value)  $default,){
final _that = this;
switch (_that) {
case _SimilarMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimilarMatch value)?  $default,){
final _that = this;
switch (_that) {
case _SimilarMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String carId,  String carName,  String imageUrl,  double similarity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimilarMatch() when $default != null:
return $default(_that.carId,_that.carName,_that.imageUrl,_that.similarity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String carId,  String carName,  String imageUrl,  double similarity)  $default,) {final _that = this;
switch (_that) {
case _SimilarMatch():
return $default(_that.carId,_that.carName,_that.imageUrl,_that.similarity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String carId,  String carName,  String imageUrl,  double similarity)?  $default,) {final _that = this;
switch (_that) {
case _SimilarMatch() when $default != null:
return $default(_that.carId,_that.carName,_that.imageUrl,_that.similarity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SimilarMatch implements SimilarMatch {
  const _SimilarMatch({required this.carId, required this.carName, required this.imageUrl, required this.similarity});
  factory _SimilarMatch.fromJson(Map<String, dynamic> json) => _$SimilarMatchFromJson(json);

@override final  String carId;
@override final  String carName;
@override final  String imageUrl;
@override final  double similarity;

/// Create a copy of SimilarMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimilarMatchCopyWith<_SimilarMatch> get copyWith => __$SimilarMatchCopyWithImpl<_SimilarMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SimilarMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimilarMatch&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.carName, carName) || other.carName == carName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.similarity, similarity) || other.similarity == similarity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,carId,carName,imageUrl,similarity);

@override
String toString() {
  return 'SimilarMatch(carId: $carId, carName: $carName, imageUrl: $imageUrl, similarity: $similarity)';
}


}

/// @nodoc
abstract mixin class _$SimilarMatchCopyWith<$Res> implements $SimilarMatchCopyWith<$Res> {
  factory _$SimilarMatchCopyWith(_SimilarMatch value, $Res Function(_SimilarMatch) _then) = __$SimilarMatchCopyWithImpl;
@override @useResult
$Res call({
 String carId, String carName, String imageUrl, double similarity
});




}
/// @nodoc
class __$SimilarMatchCopyWithImpl<$Res>
    implements _$SimilarMatchCopyWith<$Res> {
  __$SimilarMatchCopyWithImpl(this._self, this._then);

  final _SimilarMatch _self;
  final $Res Function(_SimilarMatch) _then;

/// Create a copy of SimilarMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? carId = null,Object? carName = null,Object? imageUrl = null,Object? similarity = null,}) {
  return _then(_SimilarMatch(
carId: null == carId ? _self.carId : carId // ignore: cast_nullable_to_non_nullable
as String,carName: null == carName ? _self.carName : carName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
