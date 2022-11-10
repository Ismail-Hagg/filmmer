import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

import '../controllers/actor_controller.dart';
import '../controllers/movie_detale_controller.dart';
import '../helper/constants.dart';
import '../widgets/network_image.dart';

class ActorPage extends StatelessWidget {
  final String link;
  final String id;
  final String language;
  final bool isShow;
  const ActorPage({super.key, required this.link, required this.id, required this.language, required this.isShow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var height = constraints.maxHeight;
        var width = constraints.maxWidth;
        return GetBuilder<ActorController>(
          init: Get.put(ActorController()),
          builder: (controller) => Column(
            children: [
              Container(
                  height: height * 0.3,
                  color: mainColor,
                  child: Stack(
                    children: [
                      ShapeOfView(
                        elevation: 0,
                        shape: ArcShape(
                            direction: ArcDirection.Inside,
                            height: 30,
                            position: ArcPosition.Bottom),
                        child: Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.bottomLeft,
                          stops: [
                            0.1,
                            0.4,
                            0.6,
                            0.9,
                          ],
                          colors: [
                            // Color.fromARGB(255, 250, 194, 111),
                            // Color.fromARGB(255, 228, 140, 25),
                            // Color.fromARGB(255, 216, 155, 74),
                            // Color.fromARGB(179, 230, 177, 3),
                            secondaryColor,
                            secondaryColor,
                            secondaryColor,
                            secondaryColor,
                            // mainColor,
                          ],
                        ))),
                      ),
                      Positioned(
                          right: 0,
                          left: 0,
                          bottom: 0,
                          // child: CircleContainer(
                          //   color: primaryColor,
                          //     isLocal: false,
                          //     fit: BoxFit.cover,
                          //     link: controller.model.pic.toString(),
                          //     height: size.width * 0.38,
                          //     width: size.width * 0.38,
                          //     borderWidth: 1,
                          //     borderColor: whiteColor),
                          child: GestureDetector(
                            onTap: () => controller.getImages(height, width, true, id, language, isShow),
                            child: ImageNetwork(
                                link: link,
                                height: width * 0.4,
                                width: width * 0.4,
                                color: secondaryColor,
                                fit: BoxFit.contain,
                                isMovie: false,
                                isShadow: false,
                                borderColor: orangeColor,
                                borderWidth: 2),
                          )),
                      SafeArea(
                        child: Positioned(
                          top: 0,
                          left: 0,
                          child: IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: whiteColor),
                              onPressed: () {
                                Get.back();
                              }),
                        ),
                      )
                    ],
                  )),
              Container(
                height: height * 0.7,
                color: mainColor,
              )
            ],
          ),
        );
      }),
    );
  }
}
