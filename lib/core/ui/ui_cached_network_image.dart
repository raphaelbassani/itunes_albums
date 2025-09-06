import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UICachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;

  const UICachedNetworkImage({
    required this.imageUrl,
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height ?? 60.0,
      width: width ?? 60.0,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          Container(height: height, width: width, color: Colors.grey[300]),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        color: Colors.grey,
        child: const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
