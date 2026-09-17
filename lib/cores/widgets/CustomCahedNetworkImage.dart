import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCahedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const CustomCahedNetworkImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey,
        height: 100,
        width: 100,
        child: const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
