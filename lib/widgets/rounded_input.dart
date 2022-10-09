import 'package:flutter/material.dart';



class RoundedInputField extends StatelessWidget {
  
  final Function(String?)? sav;
  final Widget? lead;
  final bool isPass;
  final String hint;
  final IconData icon;
  final TextEditingController? conreol;
  final TextInputType? isEmail;
   const RoundedInputField({Key? key, required this.hint, this.icon=Icons.person, this.conreol,  this.sav, required this.isPass, this.lead, this.isEmail, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      child: TextFormField(
        onSaved:sav ,
        obscureText: isPass,
        controller:conreol,
        style: TextStyle(
            fontFamily: 'OpenSans',
            color:Theme.of(context).colorScheme.primary,
            fontSize: size.width * 0.035,
          ),
        cursorColor: Theme.of(context).colorScheme.primary,
        keyboardType: isEmail,
        decoration:InputDecoration(
          suffixIcon: lead,
          icon: Icon(icon,color: Theme.of(context).colorScheme.primary,),
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'OpenSans',
            color:Theme.of(context).colorScheme.primary,
          ),
          border: InputBorder.none
        )
      ),
    );
  }
}


class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  const TextFieldContainer({Key? key,  this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin:  EdgeInsets.symmetric(vertical:size.height*0.007,),
      padding: const EdgeInsets.symmetric(vertical:2,horizontal: 20),
      width: size.width *0.8,
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(30),
      ),
      child:child
    );
  }
}