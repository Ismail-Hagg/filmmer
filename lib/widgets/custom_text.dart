import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final int? maxline;
  final double? spacing;
  final TextOverflow? flow;
  final TextAlign? align;
  const CustomText({Key? key, this.text, this.size, this.weight, this.color, this.maxline, this.flow, this.spacing, this.align}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??'',
      maxLines: maxline,
      textAlign: align,
      style:TextStyle(
        color: color, 
        fontSize: size,
        fontWeight: weight,
        overflow: flow,
        letterSpacing: spacing
      )
    );
  }
}