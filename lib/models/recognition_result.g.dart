// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recognition_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecognitionResult _$RecognitionResultFromJson(Map<String, dynamic> json) =>
    _RecognitionResult(
      modelName: json['modelName'] as String?,
      series: json['series'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      labels:
          (json['labels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      similarMatches:
          (json['similarMatches'] as List<dynamic>?)
              ?.map((e) => SimilarMatch.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RecognitionResultToJson(_RecognitionResult instance) =>
    <String, dynamic>{
      'modelName': instance.modelName,
      'series': instance.series,
      'confidence': instance.confidence,
      'labels': instance.labels,
      'similarMatches': instance.similarMatches,
    };

_SimilarMatch _$SimilarMatchFromJson(Map<String, dynamic> json) =>
    _SimilarMatch(
      carId: json['carId'] as String,
      carName: json['carName'] as String,
      imageUrl: json['imageUrl'] as String,
      similarity: (json['similarity'] as num).toDouble(),
    );

Map<String, dynamic> _$SimilarMatchToJson(_SimilarMatch instance) =>
    <String, dynamic>{
      'carId': instance.carId,
      'carName': instance.carName,
      'imageUrl': instance.imageUrl,
      'similarity': instance.similarity,
    };
