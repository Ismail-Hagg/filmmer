import 'package:flutter/material.dart';

import '../helper/constants.dart';

class UnderParat extends StatelessWidget {
  final String titele;
  final String navigatorText;
  final double titleSize;
  final Function()? tap;
  const UnderParat(
      {Key? key,
      required this.titele,
      required this.navigatorText,
      this.tap,
      required this.titleSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          titele,
          style: TextStyle(
              color: mainColor,
              fontFamily: 'OpenSans',
              fontSize: titleSize,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: tap,
          child: Text(navigatorText,
              style: TextStyle(
                  color: orangeColor,
                  fontFamily: 'OpenSans',
                  fontSize: titleSize,
                  fontWeight: FontWeight.w600)),
        )
      ],
    );
  }
}
