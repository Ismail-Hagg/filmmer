import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmpro/widgets/movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../helper/constants.dart';
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
  final bool isShadow;
  final String? name;
  final String? char;
  final double? nameSize;
  final double? charSize;
  final Color? nameColor;
  final Color? charColor;
  final double? topSpacing;
  final TextOverflow? flow;
  final TextAlign? align;
  final int? nameMax;
  final int? charMax;
  final FontWeight? weight;
  final String? rating;

  const ImageNetwork(
      {super.key,
      required this.link,
      required this.height,
      required this.width,
      required this.color,
      required this.fit,
      this.borderColor,
      this.borderWidth,
      required this.isMovie,
      required this.isShadow,
      this.name,
      this.char,
      this.nameSize,
      this.charSize,
      this.nameColor,
      this.charColor,
      this.topSpacing,
      this.flow,
      this.align,
      this.nameMax,
      this.charMax,
      this.weight,
      this.rating});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: link,
      imageBuilder: (context, imageProvider) => isMovie == false
          ? CircleContainer(
              name: name,
              char: char,
              nameSize: nameSize,
              charSize: charSize,
              nameColor: nameColor,
              charColor: charColor,
              topSpacing: topSpacing,
              flow: flow,
              align: align,
              nameMax: nameMax,
              charMax: charMax,
              weight: weight,
              isPicOk: true,
              shadow: isShadow,
              color: color,
              fit: fit,
              height: height,
              image: imageProvider,
              width: width,
              borderColor: borderColor ?? Colors.transparent,
              borderWidth: borderWidth ?? 0)
          : MovieWidget(
              borderColor: borderColor,
              isShadow: isShadow,
              height: height,
              width: width,
              color: color,
              rating: rating,
              image: imageProvider,
              borderWidth: borderWidth ?? 0),
      placeholder: (context, url) => isMovie == false
          ? Shimmer.fromColors(
              period: const Duration(seconds: 1),
              baseColor: secondaryColor,
              highlightColor: mainColor,
              child: CircleContainer(
                isPicOk: false,
                shadow: false,
                color: color,
                fit: fit,
                height: height,
                width: width,
                name: name,
                char: char,
                nameSize: nameSize,
                charSize: charSize,
                nameColor: nameColor,
                charColor: charColor,
                topSpacing: topSpacing,
                flow: flow,
                align: align,
                nameMax: nameMax,
                charMax: charMax,
                weight: weight,
              ),
            )
          : Shimmer.fromColors(
              period: const Duration(seconds: 1),
              baseColor: secondaryColor,
              highlightColor: mainColor,
              child: MovieWidget(
                  borderColor: borderColor,
                  isShadow: false,
                  height: height,
                  width: width,
                  color: Colors.grey,
                  rating: '',
                  borderWidth: borderWidth ?? 0)),
      errorWidget: (context, url, error) => isMovie == false
          ? CircleContainer(
              isPicOk: true,
              shadow: false,
              color: color,
              fit: fit,
              height: height,
              image: Image.asset('assets/images/no_image.png').image,
              width: width,
              name: name,
                char: char,
                nameSize: nameSize,
                charSize: charSize,
                nameColor: nameColor,
                charColor: charColor,
                topSpacing: topSpacing,
                flow: flow,
                align: align,
                nameMax: nameMax,
                charMax: charMax,
                weight: weight,
            )
          : MovieWidget(
              borderColor: borderColor,
              isShadow: isShadow,
              borderWidth: borderWidth ?? 0,
              height: height,
              width: width,
              color: color,
              //rating: '5.8',
              image: Image.asset('assets/images/no_image.png').image,
            ),
    );
  }
}
