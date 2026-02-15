import 'dart:io';
import '../constants/app_constants.dart';

abstract final class ImageUtils {
  static bool isValidImageSize(File file) {
    return file.lengthSync() <= AppConstants.maxImageSizeBytes;
  }

  static String generateImageId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String mimeTypeFromExtension(String path) {
    final ext = path.split('.').last.toLowerCase();
    return switch (ext) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      _ => 'image/jpeg',
    };
  }
}
