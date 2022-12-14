import 'package:filmpro/controllers/auth_controller.dart';
import 'package:filmpro/main.dart';
import 'package:filmpro/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

import '../helper/constants.dart';
import '../widgets/custom_text.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_input.dart';
import '../widgets/social_button.dart';
import '../widgets/under_part.dart';

class LoginPage extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  LoginPage({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            var width = constraints.maxWidth;
            var height = constraints.maxHeight;
            return SizedBox(
              height: height,
              child: Stack(
                children: [
                  Container(
                      height: (height * 0.5),
                      color:mainColor,
                      child: Center(
                        child: Icon(
                          Icons.movie_rounded,
                          color: orangeColor,
                          size: width * 0.25,
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: const  BoxDecoration(
                          color: milkyColor,
                          borderRadius:  BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      height: height * 0.6,
                      width: width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SocialButton(
                                width: width * 0.8,
                                radius: 6,
                                press:()=> Get.find<AuthController>().getNumbers(context),
                                text: 'google'.tr,
                                textColor: orangeColor,
                                titleSize: width * 0.045,
                                height: height * 0.06,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText(
                                  text: 'emailuse'.tr,
                                  color: blackClor,
                                  size: width * 0.035,
                                  weight: FontWeight.w600),
                            ),
                            Form(
                              key: _key,
                              child: Column(
                                children: [
                                  RoundedInputField(
                                    height: height,
                                    width: width,
                                    isEmail: TextInputType.emailAddress,
                                    isPass: false,
                                    hint: 'email'.tr,
                                    icon: Icons.email,
                                    sav: (value) {
                                      Get.find<AuthController>().setEmail(value.toString());
                                    },
                                  ),
                                  Obx(
                                    () => RoundedInputField(
                                      height: height,
                                      width: width,
                                      lead: IconButton(
                                          onPressed: () {
                                            Get.find<AuthController>()
                                                .obscureChange();
                                          },
                                          icon: Icon(
                                              Get.find<AuthController>()
                                                      .obcure
                                                      .value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: orangeColor)),
                                      isPass:
                                          Get.find<AuthController>().obcure.value,
                                      hint: 'pass'.tr,
                                      icon: Icons.lock,
                                      sav: (value) {
                                       Get.find<AuthController>().setPassword(value.toString());
                                      },
                                    ),
                                  ),
                                  RoundButton(
                                      width: width * 0.8,
                                      titleSize: width * 0.05,
                                      textColor:
                                          orangeColor,
                                      text: 'login'.tr,
                                      press: () {
                                        _key.currentState!.save();
                                        Get.find<AuthController>().login(context);
                                      }),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: UnderParat(
                                titleSize: width * 0.04,
                                titele: 'account'.tr,
                                navigatorText: 'make'.tr,
                                tap: () {
                                  Get.to(() =>  SignUpPage());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
