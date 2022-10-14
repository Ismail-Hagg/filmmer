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
  const MovieWidget(
      {Key? key,
      this.width,
      this.height,
      this.color,
      this.rating,
      this.borderWidth,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: height ?? 0,
            width: width ?? 0,
            decoration: BoxDecoration(
              image: DecorationImage(image: image as ImageProvider,fit: BoxFit.cover),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: color ?? Colors.transparent, width: borderWidth ?? 0),
            )),
        rating !=null? Positioned(
          top: 5,
          right: 5,
          child: Container(
            // width: 55,
            // height: 30,
            decoration: BoxDecoration(
                color: color!.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5),
                ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Center(child: CustomText(text: rating,color:milkyColor,size: 18,)),
            ),
          ),
        ):Container()
      ],
    );
  }
}
