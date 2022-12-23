import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constants.dart';
import '../models/images_model.dart';
import '../services/images_service.dart';
import '../widgets/network_image.dart';

class ActorController extends GetxController {
  final RxInt _imagesCounter = 0.obs;
  int get imagesCounter => _imagesCounter.value;

  // call api to get images
  void getImages(double height, double width, bool isActor, String id,
      String language, bool isShow) async {
    ImagesModel model = ImagesModel();
    _imagesCounter.value = 1;
    Get.dialog(Obx(
      () => Center(
        child: _imagesCounter.value == 1
            ? const CircularProgressIndicator(
                color: orangeColor,
              )
            : model.isError == false
                ? CarouselSlider.builder(
                options: CarouselOptions(
                    height: height * 0.6, enlargeCenterPage: true),
                itemCount: model.links!.length,
                itemBuilder: (context, index, realIndex) {
                  return ImageNetwork(
                    link: imagebase + model.links![index],
                    height: height * 0.95,
                    width: width * 0.8,
                    color: orangeColor,
                    fit: BoxFit.contain,
                    isMovie: true,
                    isShadow: false,
                  );
                },
                  )
                : AlertDialog(
                    title: Text('error'.tr),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: orangeColor,
                        ),
                        child: Text("answer".tr),
                        onPressed: () async => {
                          Get.back(),
                        },
                      ),
                    ],
                  ),
      ),
    ));
    ImagesService()
        .getImages(
            isActor
                ? 'person'
                : isShow == true
                    ? 'tv'
                    : 'movie',
            id,
            language.substring(0, language.indexOf('_')))
        .then((val) {
      model = val;
      _imagesCounter.value = 0;
    });
  }
}
