import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmpro/widgets/movie_widget.dart';
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
  final bool isMovie;

  const ImageNetwork(
      {super.key,
      required this.link,
      required this.height,
      required this.width,
      required this.color,
      required this.fit,
      this.borderColor,
      this.borderWidth,
      required this.isMovie});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: link,
      imageBuilder: (context, imageProvider) => isMovie==false? CircleContainer(
          isPicOk: true,
          shadow: false,
          color: color,
          fit: fit,
          height: height,
          image: imageProvider,
          width: width,
          borderColor: borderColor ?? Colors.transparent,
          borderWidth: borderWidth ?? 0):MovieWidget(
            height: height,
            width: width,
            color: color,
            rating: '5.8',
            image: imageProvider,
            borderWidth:2

          ),
      placeholder: (context, url) => isMovie==false?CircleContainer(
        isPicOk: true,
        shadow: false,
        color: color,
        fit: fit,
        height: height,
        image: Image.asset('assets/images/google_logo.png').image,
        width: width,
      ):MovieWidget(
            height: height,
            width: width,
            color: color,
            //rating: '5.8',
            image: Image.asset('assets/images/google_logo.png').image,
            borderWidth:2
          ),
      errorWidget: (context, url, error) =>isMovie==false? CircleContainer(
        isPicOk: true,
        shadow: false,
        color: color,
        fit: fit,
        height: height,
        image: Image.asset('assets/images/no_image.png').image,
        width: width,
      ):MovieWidget(

        borderWidth:2,
            height: height,
            width: width,
            color: color,
            //rating: '5.8',
            image: Image.asset('assets/images/google_logo.png').image,

          ),
    );
  }
}
