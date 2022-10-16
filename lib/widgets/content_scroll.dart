import 'package:filmpro/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../helper/constants.dart';
import '../models/home_page_model.dart';
import 'custom_text.dart';
import 'network_image.dart';

class ContentScroll extends StatelessWidget {
  final double paddingY;
  final String title;
  final double size;
  final Color color;
  final double iconSize;
  final double height;
  final double picHeight;
  final double picWidth;
  final bool isMovie;
  final bool isArrow;
  final HomePageModel model;
  final Color? borderColor;
  final double? borderWidth;
  final String link;
  const ContentScroll(
      {Key? key,
      required this.paddingY,
      required this.title,
      required this.size,
      required this.color,
      required this.iconSize,
      required this.height,
      required this.picHeight,
      required this.picWidth,
      required this.isMovie,
      required this.isArrow,
      required this.model, this.borderColor, this.borderWidth, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: title,
                      size: size,
                      color: milkyColor,
                      weight: FontWeight.bold,
                    ),
                    isArrow
                        ? IconButton(
                            splashRadius: 15,
                            onPressed: () {
                              Get.find<HomeController>()
                              .goToSearch(false, link.toString(), title);
                            },
                            icon: Icon(Icons.arrow_forward,
                                color: milkyColor, size: iconSize))
                        : Container()
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              model.isError == true
        ? SizedBox(
            height: height,
            child:  Center(
              child: GestureDetector(
                onTap: ()=>Get.find<HomeController>().apiCall(Get.find<HomeController>().model.language),
                child:Icon(Icons.refresh,size:height*0.2,color: orangeColor,),
              )
            ),
          )
        :
              SizedBox(
                height: height,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: model.results!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingY),
                      child: GestureDetector(
                        onTap: () {
                          print(model.results![index].title);
                        },
                        child: ImageNetwork(
                          borderWidth: borderWidth,
                          borderColor: borderColor??Colors.transparent,
                          rating: model.results?[index].voteAverage != null
                              ? model.results![index].voteAverage.toString()
                              : '0.0',
                          link: imagebase +
                              (model.results?[index].posterPath).toString(),
                          height: picHeight,
                          width: picWidth,
                          isMovie: isMovie,
                          isShadow: false,
                          color: color,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
  }
}
