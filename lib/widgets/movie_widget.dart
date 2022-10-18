import 'package:flutter/material.dart';

import '../helper/constants.dart';
import 'custom_text.dart';

class MovieWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final String? rating;
  final double? borderWidth;
  final ImageProvider? image;
  final bool isShadow;
  final Color? borderColor;
  const MovieWidget(
      {Key? key,
      this.width,
      this.height,
      this.color,
      this.rating,
      this.borderWidth,
      this.image,
      required this.isShadow,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        image != null
            ? Container(
                height: height ?? 0,
                width: width ?? 0,
                decoration: BoxDecoration(
                  boxShadow: [
                    isShadow == true
                        ? const BoxShadow(
                            color: secondaryColor,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        : const BoxShadow()
                  ],
                  image: DecorationImage(
                      image: image as ImageProvider, fit: BoxFit.cover),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: borderColor ?? Colors.transparent,
                      width: borderWidth ?? 0),
                ))
            : Container(
                height: height ?? 0,
                width: width ?? 0,
                decoration: BoxDecoration(
                  boxShadow: [
                    isShadow == true
                        ? const BoxShadow(
                            color: secondaryColor,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        : const BoxShadow()
                  ],
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: borderColor ?? Colors.transparent,
                      width: borderWidth ?? 0),
                )),
        rating != null
            ? Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color:rating=='0.0'?Colors.transparent: color!.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Center(
                        child: CustomText(
                      text: rating=='0.0'?'':rating,
                      color: milkyColor,
                      size: 18,
                    )),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
