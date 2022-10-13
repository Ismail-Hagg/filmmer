import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'custom_text.dart';

class SocialButton extends StatelessWidget {
  final double width;
  final double radius;
  final Function() press;
  final String text;
  final Color textColor;
  final double titleSize;
  final double height;
  const SocialButton(
      {Key? key,
      required this.width,
      required this.radius,
      required this.press,
      required this.text,
      required this.textColor,
      required this.titleSize,
      required this.height

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
           primary: Theme.of(context).colorScheme.secondary,
              ),
          onPressed: press,
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('assets/images/google.svg',width:width*0.1,height:width*0.1),
                    CustomText(
                        text: text,
                        color: textColor,
                        size: titleSize,
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
