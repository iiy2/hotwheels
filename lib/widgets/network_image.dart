import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Cross-platform network image widget.
///
/// On web, uses [Image.network] (avoids caching issues with CanvasKit).
/// On native, uses [CachedNetworkImage] for disk caching.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  final String url;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      debugPrint('[IMG] rendering Image.network url=${url.substring(0, url.length.clamp(0, 80))}...');
      return Image.network(
        url,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            debugPrint('[IMG] LOADED url=${url.substring(0, url.length.clamp(0, 80))}...');
            return child;
          }
          debugPrint('[IMG] loading progress=${loadingProgress.cumulativeBytesLoaded}/${loadingProgress.expectedTotalBytes}');
          return placeholder ?? const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
              debugPrint('[IMG ERROR] url=$url error=$error');
              return errorWidget ?? const Icon(Icons.broken_image);
            },
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      placeholder: placeholder != null ? (_, __) => placeholder! : null,
      errorWidget: errorWidget != null ? (_, __, ___) => errorWidget! : null,
    );
  }
}
