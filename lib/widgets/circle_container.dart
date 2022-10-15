import 'dart:io';

import 'package:flutter/material.dart';

import 'custom_text.dart';

class CircleContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final ImageProvider? image;
  final BoxFit? fit;
  final Color? borderColor;
  final double? borderWidth;
  final IconData? icon;
  final bool shadow;
  final Color? iconColor;
  final bool isPicOk;
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

  const CircleContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    this.image,
    this.fit,
    this.borderColor,
    this.borderWidth,
    this.icon,
    required this.shadow,
    this.iconColor,
    required this.isPicOk,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget contain = isPicOk == true
        ? Container(
          width: width,
          child: Column(
              children: [
                Container(
                    height: height,
                    decoration: BoxDecoration(
                      boxShadow: [
                        shadow == true
                            ? BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              )
                            : const BoxShadow()
                      ],
                      border: Border.all(
                        color: borderColor ?? Colors.transparent,
                        width: borderWidth ?? 0.0,
                      ),
                      color: color,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: image as ImageProvider,
                        fit: fit,
                      ),
                    )),
                SizedBox(
                  height: topSpacing ?? 0.0,
                ),
                name != null
                    ? CustomText(
                        align: TextAlign.center,
                        text: name,
                        size: nameSize,
                        color: nameColor,
                        flow: flow,
                        maxline: nameMax,
                        weight: weight,
                      )
                    : Container(),
                char != null
                    ? CustomText(
                        align: TextAlign.center,
                        text: char,
                        size: charSize,
                        color: charColor,
                        flow: flow,
                        maxline: charMax,
                        weight: weight,
                      )
                    : Container()
              ],
            ),
        )
        : Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor ?? Colors.transparent,
                width: borderWidth ?? 0.0,
              ),
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                shadow == true
                    ? BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    : const BoxShadow()
              ],
            ),
            child: Center(
                child: Icon(
              icon,
              size: width * 0.45,
              color: iconColor,
            )),
          );

    return contain;
  }
}
