import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmpro/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../helper/constants.dart';
import '../widgets/circle_container.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_input.dart';
import '../widgets/under_part.dart';

class SignUpPage extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
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
                color: mainColor,
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    height: height * 0.7,
                    width: width,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 214, 211, 211),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Form(
                            key: _key,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: GetBuilder<AuthController>(
                                    init: Get.find<AuthController>(),
                                    builder: (controller) => Stack(
                                      children: [
                                        CircleContainer(
                                          isPicOk: controller.isPicked,
                                          image:
                                              Image.file(controller.image).image,
                                          fit: BoxFit.cover,
                                          shadow: true,
                                          color: mainColor,
                                          height: width * 0.35,
                                          width: width * 0.35,
                                          icon: Icons.person,
                                          borderWidth: 2,
                                          borderColor: orangeColor,
                                          iconColor: orangeColor,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: width * 0.03,
                                          child: GestureDetector(
                                            onTap: () =>
                                                controller.openImagePicker(),
                                            child: CircleContainer(
                                              isPicOk: false,
                                              iconColor: const Color.fromARGB(
                                                  255, 214, 211, 211),
                                              shadow: false,
                                              color:orangeColor,
                                              height: width * 0.08,
                                              width: width * 0.08,
                                              icon: controller.isPicked == false
                                                  ? Icons.add
                                                  : Icons.delete,
                                              borderWidth: 1,
                                              borderColor: orangeColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                RoundedInputField(
                                  height: height,
                                  width: width,
                                  isPass: false,
                                  hint: 'name'.tr,
                                  icon: Icons.person,
                                  sav: (value) {
                                    Get.find<AuthController>().setUsername(value.toString());
                                  },
                                ),
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
                                RoundedInputField(
                                  height: height,
                                  width: width,
                                  isEmail: TextInputType.emailAddress,
                                  isPass: false,
                                  hint: 'pass'.tr,
                                  icon: Icons.lock,
                                  sav: (value) {
                                    Get.find<AuthController>().setPassword(value.toString());
                                  },
                                ),
                                RoundButton(
                                    width: width * 0.8,
                                    titleSize: width * 0.05,
                                    textColor:
                                        orangeColor,
                                    text: 'make'.tr,
                                    press: () {
                                       _key.currentState!.save();
                                      Get.find<AuthController>().register(context);
                                    }),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: UnderParat(
                                    titleSize: width * 0.04,
                                    titele: 'already'.tr,
                                    navigatorText: 'Login'.tr,
                                    tap: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        );
      }),
    ));
  }
}
