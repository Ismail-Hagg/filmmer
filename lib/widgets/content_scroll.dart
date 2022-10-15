import 'package:filmpro/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final List<String> links;
  final bool isMovie;
  final bool isArrow;
  final HomePageModel model;
  const ContentScroll(
      {Key? key,
      required this.paddingY,
      required this.title,
      required this.size,
      required this.color,
      required this.iconSize,
      required this.height,
      required this.links,
      required this.picHeight,
      required this.picWidth,
      required this.isMovie,
      required this.isArrow,
      required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return model.isError==true?
    Container(
      height: height,
      child: const Center(child: CircularProgressIndicator(),),
    )
    : Column(
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
                        // Get.find<HomeController>().getUpcoming(upc, Get.find<HomeController>().model.language);
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
        SizedBox(
          height: height,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: links.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingY),
                child: GestureDetector(
                  onTap: (){
                    print(model.results![index].title);
                  },
                  child: ImageNetwork(
                    rating: model.results?[index].voteAverage!=null?model.results![index].voteAverage.toString():'0.0',
                    link: imagebase+ (model.results?[index].posterPath).toString(),
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
