import 'package:filmpro/widgets/circle_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../helper/constants.dart';
import '../models/home_page_model.dart';
import '../models/movie_deltale_model.dart';
import 'custom_text.dart';
import 'network_image.dart';

class ContentScrolling extends StatelessWidget {
  final Color color;
  final Color textColor;
  final Color? borderColor;
  final double inHeight;
  final double inWidth;
  final double paddingY;
  final double pageWidth;
  final double? borderWidth;
  final double height;
  final bool isError;
  final bool isArrow;
  final bool isTitle;
  final bool isMovie;
  final bool isShadow;
  final bool isFirstPage;
  final String? title;
  final String? link;
  final BoxFit fit;
  final HomePageModel? model;
  final MovieDetaleModel? detales;
  final Function() reload;
  final bool? isWaiting;

  const ContentScrolling(
      {super.key,
      required this.color,
      this.borderColor,
      required this.inHeight,
      required this.inWidth,
      required this.paddingY,
      required this.pageWidth,
      this.borderWidth,
      required this.isError,
      required this.isArrow,
      required this.isTitle,
      required this.isMovie,
      required this.isShadow,
      this.title,
      required this.fit,
      this.model,
      this.detales,
      required this.reload,
      required this.textColor,
      required this.isFirstPage,
      required this.height,
      this.link,
      this.isWaiting});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          isTitle
              ? CustomText(
                  text: title.toString(),
                  size: pageWidth * 0.05,
                  color: textColor,
                  weight: FontWeight.bold,
                )
              : Container(),
          isArrow
              ? IconButton(
                  splashRadius: 15,
                  onPressed: () {
                    Get.find<HomeController>()
                        .goToSearch(false, link.toString(), title.toString());
                  },
                  icon: Icon(Icons.arrow_forward,
                      color: textColor, size: pageWidth * 0.065))
              : Container()
        ]),
      ),
      const SizedBox(
        height: 15,
      ),
      isError == true
          ? SizedBox(
              height: height,
              child: Center(
                  child: GestureDetector(
                onTap: reload,
                child: Icon(
                  Icons.refresh,
                  size: height * 0.2,
                  color: color,
                ),
              )),
            )
          : SizedBox(
              height: height,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: isFirstPage
                    ? model!.results!.length
                    : isMovie
                        ? detales!.recomendation!.results!.length
                        : detales!.cast!.cast!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingY),
                    child: GestureDetector(
                        onTap: () {
                          isFirstPage
                              ? Get.find<HomeController>()
                                  .navToDetale(model!.results![index])
                              : isMovie
                                  ? Get.find<HomeController>().navToDetale(
                                      detales!.recomendation!.results![index])
                                  : Get.find<HomeController>().navToCast(
                                      imagebase +
                                          detales!
                                              .cast!.cast![index].profilePath
                                              .toString(),
                                      detales!.cast!.cast![index].id
                                          .toString(),Get.find<HomeController>().model.language.toString(),false);
                        },
                        child: isWaiting == null
                            ? ImageNetwork(
                                name: isFirstPage == false
                                    ? isMovie == false
                                        ? detales!.cast!.cast![index].name
                                        : ''
                                    : '',
                                char: isFirstPage == false
                                    ? isMovie == false
                                        ? detales!.cast!.cast![index].character
                                        : ''
                                    : '',
                                nameColor: orangeColor,
                                charColor: whiteColor,
                                topSpacing: height * 0.05,
                                nameSize: pageWidth * 0.033,
                                charSize: pageWidth * 0.026,
                                nameMax: 1,
                                charMax: 1,
                                flow: TextOverflow.clip,
                                align: TextAlign.center,
                                borderWidth: borderWidth ?? 0,
                                borderColor: borderColor ?? Colors.transparent,
                                rating: isFirstPage
                                    ? model!.results![index].voteAverage
                                        .toString()
                                    : isMovie
                                        ? detales!.recomendation!
                                            .results![index].voteAverage
                                            .toString()
                                        : '0.0',
                                link: isFirstPage
                                    ? imagebase +
                                        (model!.results?[index].posterPath)
                                            .toString()
                                    : isMovie
                                        ? imagebase +
                                            (detales!.recomendation!
                                                    .results![index].posterPath)
                                                .toString()
                                        : imagebase +
                                            (detales!.cast!.cast![index]
                                                    .profilePath)
                                                .toString(),
                                height: inHeight,
                                width: inWidth,
                                isMovie: isMovie,
                                isShadow: isShadow,
                                color: color,
                                fit: BoxFit.contain,
                              )
                            : isMovie == false
                                ? CircleContainer(
                                    fit: fit,
                                    height: inHeight,
                                    width: inWidth,
                                    color: color,
                                    shadow: false,
                                    isPicOk: true,
                                    image: Image.asset(detales!
                                            .cast!.cast![0].profilePath
                                            .toString())
                                        .image,
                                    name: detales!.cast!.cast![0].name,
                                    char: detales!.cast!.cast![0].character,
                                    nameColor: orangeColor,
                                    charColor: whiteColor,
                                    topSpacing: height * 0.05,
                                    nameSize: pageWidth * 0.03,
                                    charSize: pageWidth * 0.02,
                                    nameMax: 1,
                                    charMax: 1,
                                    flow: TextOverflow.clip,
                                    align: TextAlign.center,
                                    weight: FontWeight.w600,
                                  )
                                : Container()),
                  );
                },
              ),
            )
    ]);
  }
}
