import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../constants/app_constants.dart';

abstract final class ImageUtils {
  static bool isValidImageSize(File file) {
    if (kIsWeb) return true; // dart:io File ops not supported on web
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
