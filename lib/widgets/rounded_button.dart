import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'custom_text.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Function()? press;
  final Color? textColor;
  final double width;
  final double titleSize;
  const RoundButton(
      {Key? key, required this.text, this.press, this.textColor = Colors.white, required this.width, required this.titleSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 3,
        blurRadius: 7,
        offset:const Offset(0, 3), 
      ),
    ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          onPressed: press,
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.secondary,
              padding:  EdgeInsets.symmetric( vertical: width*0.04),
              textStyle: TextStyle(
                letterSpacing: 2,
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              )),
          child: Obx(
            () => Get.find<AuthController>().count.value == 1
                ?  CircularProgressIndicator(
                    color:Theme.of(context).colorScheme.primary,
                  )
                : CustomText(text: text, color: textColor, size: titleSize,),
          ),
        ),
      ),
    );
  }
}
