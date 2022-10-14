import 'package:flutter/material.dart';

import '../helper/constants.dart';

class RoundedInputField extends StatelessWidget {
  final Function(String?)? sav;
  final Widget? lead;
  final bool isPass;
  final String hint;
  final IconData icon;
  final TextEditingController? conreol;
  final TextInputType? isEmail;
  final double height;
  final double width;
  const RoundedInputField({
    Key? key,
    required this.hint,
    this.icon = Icons.person,
    this.conreol,
    this.sav,
    required this.isPass,
    this.lead,
    this.isEmail,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      height: height,
      width: width,
      child: TextFormField(
          onSaved: sav,
          obscureText: isPass,
          controller: conreol,
          style: TextStyle(
            fontFamily: 'OpenSans',
            color: orangeColor,
            fontSize: width * 0.035,
          ),
          cursorColor: orangeColor,
          keyboardType: isEmail,
          decoration: InputDecoration(
              suffixIcon: lead,
              icon: Icon(
                icon,
                color: orangeColor,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                fontFamily: 'OpenSans',
                color: orangeColor,
              ),
              border: InputBorder.none)),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  final double height;
  final double width;
  const TextFieldContainer(
      {Key? key, this.child, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: height * 0.007,
        ),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        width: width * 0.8,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: child);
  }
}
