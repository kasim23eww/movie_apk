import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, __) => placeholder ?? Bone(width: width, height: height),
      errorWidget:
          (_, __, ___) =>
              errorWidget ?? Icon(Icons.broken_image, size:  100,color: Colors.white,),
    );

    return borderRadius != null
        ? ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          child: image,
        )
        : image;
  }
}
