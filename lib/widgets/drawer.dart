// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:filmpro/local_storage/user_data_pref.dart';
import 'package:filmpro/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../helper/constants.dart';
import '../models/user_model.dart';
import 'circle_container.dart';
import 'custom_text.dart';

class Draw extends StatelessWidget {
  Draw({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [header(constraints.maxHeight, constraints.maxWidth),DrawItems(constraints.maxHeight, constraints.maxWidth)],
        );
      }),
    );
  }
}

Widget header(double height, double width) {
  return SafeArea(
      child: FutureBuilder(
          future: UserDataPref().getUser,
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                  height: height * 0.27,
                  color: mainColor,
                  child: snapshot.data!.isSocial
                      ? Padding(
                          padding: EdgeInsets.all(height * 0.01),
                          child: ImageNetwork(
                            topSpacing: height * 0.015,
                            flow: TextOverflow.ellipsis,
                            char: snapshot.data!.email,
                            charColor: orangeColor,
                            charSize: width * 0.05,
                            name: snapshot.data!.userName,
                            nameColor: milkyColor,
                            nameSize: width * 0.07,
                            borderWidth: 2,
                            borderColor: orangeColor,
                            color: mainColor,
                            fit: BoxFit.contain,
                            height: height * 0.17,
                            isMovie: false,
                            isShadow: false,
                            link: snapshot.data!.onlinePicPath,
                            width: height * 0.17,
                          ),
                        )
                      : snapshot.data!.isPicLocal
                          ? Padding(
                              padding: EdgeInsets.all(height * 0.01),
                              child: CircleContainer(
                                  topSpacing: height * 0.017,
                                  fit: BoxFit.cover,
                                  borderWidth: 2,
                                  borderColor: orangeColor,
                                  char: snapshot.data!.email,
                                  charColor: orangeColor,
                                  charSize: width * 0.05,
                                  name: snapshot.data!.userName,
                                  nameColor: milkyColor,
                                  nameSize: width * 0.07,
                                  color: secondaryColor,
                                  height: height * 0.17,
                                  isPicOk: true,
                                  shadow: false,
                                  width: height * 0.17,
                                  image: Image.file(
                                          File(snapshot.data!.localPicPath))
                                      .image),
                            )
                          : Padding(
                            padding: EdgeInsets.all(height * 0.01),
                            child: CircleContainer(
                                color: secondaryColor,
                                height: height *0.17,
                                isPicOk: false,
                                shadow: false,
                                width: height *0.17,
                                icon: Icons.person,
                                iconColor: orangeColor,
                                borderWidth: 2,
                                    borderColor: orangeColor,
                                    char: snapshot.data!.email,
                                  charColor: orangeColor,
                                  charSize: width * 0.05,
                                  name: snapshot.data!.userName,
                                  nameColor: milkyColor,
                                  nameSize: width * 0.07,
                                  topSpacing: height * 0.017,
                              ),
                          ));
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: orangeColor,
              ));
            }
          }));
}

Widget DrawItems(double height, double width) {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: const Icon(
            Icons.person,
            color: orangeColor,
          ),
          title: CustomText(
            text: 'myaccount'.tr,
            size: width * 0.05,
          ),
          onTap: () {
            Get.back();
           // Get.to(() => WatchList());
          },
        ),
         ListTile(
          leading: const Icon(
            Icons.list,
            color: orangeColor,
          ),
          title: CustomText(
            text: 'watchList'.tr,
            size: width * 0.05,
          ),
          onTap: () {
            Get.back();
           // Get.to(() => WatchList());
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite, color: orangeColor),
          title: CustomText(
            text: 'favourite'.tr,
            size: width * 0.05,
          ),
          onTap: () {
            Get.back();
            //Get.to(() => FavoritesScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.tv, color: orangeColor),
          title: CustomText(
            text: 'keeping'.tr,
            size: width * 0.05,
          ),
          onTap: () {
            Get.back();
            //Get.to(() => FavoritesScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings, color: orangeColor),
          title: CustomText(
            text: 'settings'.tr,
            size: width * 0.05,
          ),
          onTap: () {
            Get.back();
            //Get.to(() => Settings());
            Get.find<AuthController>().signOut();
          },
        ),
      ],
    ),
  );
}
