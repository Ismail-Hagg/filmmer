import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

import '../controllers/movie_detale_controller.dart';
import '../helper/constants.dart';
import '../widgets/content_scroll.dart';
import '../widgets/custom_text.dart';

class MovieDetalePage extends StatelessWidget {
   MovieDetalePage({Key? key}) : super(key: key);

  List<String> lst=[
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/grsIJAo7a37SAVl3La5aaUFpVla.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/jZhHfPt9HUyVdXuTvGLlcnympE5.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/wr9Q5IiRpKl10IuJhDmC7QXDuqz.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/sglKcvdU3e8hTy1kOghEbT0GdHS.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/iY6ZIEoi7awz69CzvkOgN0YB05l.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/fF740MIubP6IBGeS80KMmELnHCi.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/lLLLqscRNnbFC7GQNqYIQ5WsoCJ.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/8vxcFlUeIwNH0uIoZq34uagaLAr.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/1qOHNQerubLL28fkAX2swY9bAIz.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/bXYxZkchxjozc8gPiImMOouG2ZA.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/oU53nWLQ6wFHzERwSi1fD53LxZB.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/grsIJAo7a37SAVl3La5aaUFpVla.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/jZhHfPt9HUyVdXuTvGLlcnympE5.jpg',
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/8vxcFlUeIwNH0uIoZq34uagaLAr.jpg',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var height = constraints.maxHeight;
        var width = constraints.maxWidth;
        return SingleChildScrollView(
          child: GetBuilder<MovieDetaleController>(
            init: Get.put(MovieDetaleController()),
            builder: (controller) => Column(
              children: [
                SizedBox(
                  height: height * 0.44,
                  child: Stack(children: [
                    SizedBox(
                      height: height * 0.4,
                      child: ShapeOfView(
                          elevation: 25,
                          shape: ArcShape(
                              direction: ArcDirection.Outside,
                              height: 50,
                              position: ArcPosition.Bottom),
                          child: CachedNetworkImage(
                              imageUrl:
                                  'https://images.unsplash.com/photo-1665945203723-d823de195bf4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ))),
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) =>
                                  Container())),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: RawMaterialButton(
                        padding: const EdgeInsets.all(10),
                        elevation: 12,
                        onPressed: () {
                          // controller.goToTrailer();
                        },
                        shape: const CircleBorder(),
                        fillColor: whiteColor,
                        child:
                            //  controller.load == 0
                            //     ? const Center(
                            //         child: CircularProgressIndicator(color: orangeColor),
                            //       )
                            //     :
                            Icon(Icons.play_arrow,
                                color: orangeColor, size: width * 0.13),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  splashRadius: 15,
                                  icon: Icon(Icons.add,
                                      color: orangeColor, size: width * 0.08),
                                  //onPressed: () => controller.watch()),
                                  onPressed: () {}),
                              CustomText(
                                text: '0.0'
                                // controller.detales.voteAverage!
                                //     .toStringAsFixed(1)
                                ,
                                color: orangeColor,
                                size: width * 0.065,
                              )
                            ]),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(Icons.arrow_back,
                                    color: whiteColor, size: width * 0.067),
                              ),
                              // Obx(
                              //   () => GestureDetector(
                              //     //onTap: () => controller.sendObject(),
                              //     onTap: (){},
                              //     child:
                              //     // controller.flip.value == 0
                              //     //     ? const Icon(Icons.favorite_outline,
                              //     //         color: whiteColor, size: 30)
                              //     //     :
                              //         const Icon(Icons.favorite,
                              //             color: orangeColor, size: width * 0.067),
                              //   ),
                              // )
                            ]),
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6),
                  child: CustomText(
                      text: 'title of the movie title of the movie ',
                      color: whiteColor,
                      size: width * 0.055,
                      maxline: 2,
                      weight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                      height: height * 0.05,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            //  controller.detales.genres != null
                            //     ? controller.detales.genres!.length
                            //     :
                            3,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomText(
                              text:
                                  // controller.detales.genres == null
                                  //     ?
                                  'Genre',
                              //: controller.detales.genres![index].name,
                              color: orangeColor,
                              size: width * 0.045);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return CustomText(
                              text: ' | ',
                              color: orangeColor,
                              size: width * 0.04);
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: (width - 32) * 0.2,
                            child: Column(children: [
                              CustomText(
                                text: 'Year'.tr,
                                color: whiteColor,
                                size: width * 0.04,
                                flow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3),
                              CustomText(
                                text:
                                    //  controller.detales.productionCountries == null
                                    //     ?
                                    'Year'.tr,
                                // : controller.detales.releaseDate!,
                                color: orangeColor,
                                size: width * 0.04,
                                weight: FontWeight.bold,
                                flow: TextOverflow.ellipsis,
                              )
                            ])),
                        SizedBox(
                            width: (width - 32) * 0.6,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: 'country'.tr,
                                    color: whiteColor,
                                    size: width * 0.04,
                                    flow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 3),
                                  CustomText(
                                    align: TextAlign.left,
                                    text:
                                        // controller.detales.productionCountries ==
                                        //         null
                                        // ?
                                        'country'.tr,
                                    // : controller.detales.originCountry != ''
                                    //     ? countries[
                                    //         controller.detales.originCountry]
                                    //     : controller.detales
                                    //         .productionCountries![0].name,
                                    color: orangeColor,
                                    size: width * 0.04,
                                    weight: FontWeight.bold,
                                    flow: TextOverflow.ellipsis,
                                  )
                                ])),
                        SizedBox(
                            width: (width - 32) * 0.2,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text:
                                        // controller.detales.isShow == false
                                        //     ?
                                        'length'.tr,
                                    // : 'seasons'.tr,
                                    color: whiteColor,
                                    size: width * 0.04,
                                    flow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 3),
                                  CustomText(
                                    text: 'thing',
                                    //controller.detales.runtime.toString(),
                                    color: orangeColor,
                                    size: width * 0.04,
                                    weight: FontWeight.bold,
                                  )
                                ])),
                      ]),
                ),
                 //                 controller.detales.overview == ''
                // ? Container()
                //: 
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SizedBox(
                      height: height * 0.12,
                      child: SingleChildScrollView(
                          child: CustomText(
                        text: 'Overview',
                        //controller.detales.overview,
                        size: width * 0.035,
                        color: whiteColor,
                      )),
                    ),
                  ),
                  // for the actors check if there's data first or show an empty container
                  // ContentScroll(
                  //   paddingY: 8,
                  //   title:'Cast',
                  //   size:50,
                  //   color: mainColor,
                  //   iconSize: 30,
                  //   height: height * 0.2,
                  // )

              ],
            ),
          ),
        );
      }),
    );
  }
}
