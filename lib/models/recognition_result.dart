import 'package:freezed_annotation/freezed_annotation.dart';

part 'recognition_result.freezed.dart';
part 'recognition_result.g.dart';

@freezed
abstract class RecognitionResult with _$RecognitionResult {
  const factory RecognitionResult({
    String? modelName,
    String? series,
    @Default(0.0) double confidence,
    @Default([]) List<String> labels,
    @Default([]) List<SimilarMatch> similarMatches,
  }) = _RecognitionResult;

  factory RecognitionResult.fromJson(Map<String, dynamic> json) =>
      _$RecognitionResultFromJson(json);
}

@freezed
abstract class SimilarMatch with _$SimilarMatch {
  const factory SimilarMatch({
    required String carId,
    required String carName,
    required String imageUrl,
    required double similarity,
  }) = _SimilarMatch;

  factory SimilarMatch.fromJson(Map<String, dynamic> json) =>
      _$SimilarMatchFromJson(json);
}
