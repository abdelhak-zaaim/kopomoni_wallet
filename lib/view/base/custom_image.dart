import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String? placeholder;
  const CustomImage({Key? key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: CachedNetworkImage(
        imageUrl: image, height: height, width: width, fit: fit,
        placeholder: (context, url) => Image.asset(placeholder!, height: height, width: width, fit: fit),
        errorWidget: (context, url, error) => Image.asset(placeholder!, height: height, width: width, fit: fit),
      ),
    );
  }
}