import 'dart:io';

import 'package:flutter/material.dart';

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

  const CircleContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    this.image,
    this.fit,
    this.borderColor,
    this.borderWidth, this.icon, required this.shadow, this.iconColor,required this.isPicOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget contain= isPicOk==true? Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow:  [
           shadow==true? BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ):const BoxShadow(
              
            )
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
        )):
        Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0.0,
          ),
          color: color, 
          shape: BoxShape.circle,
          boxShadow:  [
           shadow==true? BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ):const BoxShadow(
              
            )
          ],
          
        ),
        child:  Center(child: Icon(
          icon,
          size: width*0.45,
          color: iconColor,
        )),
        );

        return contain;
  }
}
