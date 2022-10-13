import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'circle_container.dart';

class ImageNetwork extends StatelessWidget {
  final String link;
  final double height;
  final double width;
  final Color color;
  final BoxFit fit;
  final Color? borderColor;
  final double? borderWidth;

  const ImageNetwork(
      {super.key,
      required this.link,
      required this.height,
      required this.width,
      required this.color,
      required this.fit,
      this.borderColor,
      this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: link,
      imageBuilder: (context, imageProvider) => CircleContainer(
        isPicOk: true,
        shadow: false,
        color: color,
        fit: fit,
        height: height,
        image: imageProvider,
        width: width,
        borderColor: borderColor??Colors.transparent,
        borderWidth: borderWidth??0
      ),
      placeholder: (context, url) => CircleContainer(
        isPicOk: true,
        shadow: false,
        color: color,
        fit: fit,
        height: height,
        image: Image.asset('assets/images/google_logo.png').image,
        width: width,
      ),
      errorWidget: (context, url, error) => CircleContainer(
        isPicOk: true,
        shadow: false,
        color: color,
        fit: fit,
        height: height,
        image: Image.asset('assets/images/no_image.png').image,
        width: width,
      ),
    );
  }
}
