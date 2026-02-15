abstract final class AppConstants {
  static const String appName = 'Hot Wheels Collection';

  static const int maxImagesPerCar = 20;
  static const int maxImageSizeBytes = 10 * 1024 * 1024; // 10 MB
  static const int minCarYear = 1968;
  static const int maxCarYear = 2030;

  static const int embeddingDimension = 512; // CLIP ViT-B/32
  static const int similarSearchLimit = 5;

  static const double carCardAspectRatio = 0.75;
  static const int collectionGridCrossAxisCount = 2;
}
