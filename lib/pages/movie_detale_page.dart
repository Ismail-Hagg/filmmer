import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmpro/widgets/circle_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/movie_detale_controller.dart';
import '../helper/constants.dart';
import '../helper/countries.dart';
import '../helper/utils.dart';
import '../widgets/content_scrolll.dart';
import '../widgets/custom_text.dart';
import '../widgets/network_image.dart';

class MovieDetalePage extends StatelessWidget {
  MovieDetalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: secondaryColor,
      body: GetBuilder<MovieDetaleController>(
        init: Get.put(MovieDetaleController()),
        builder: (controller) => LayoutBuilder(
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
                                imageUrl: controller.model.isError != true
                                    ? imagebase +
                                        controller.model.posterPath.toString()
                                    : controller.backUp.posterPath.toString(),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ))),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                      period: const Duration(seconds: 1),
                                      baseColor: mainColor,
                                      highlightColor: secondaryColor,
                                      child: Container(
                                        height: height * 0.4,
                                        color: mainColor,
                                      ),
                                    ),
                                errorWidget: (context, url, error) => Container(
                                      height: height * 0.4,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: Image.asset(
                                                      'assets/images/no_image.png')
                                                  .image)),
                                    ))),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: RawMaterialButton(
                          padding: const EdgeInsets.all(10),
                          elevation: 12,
                          onPressed: () {
                            controller.queryAll();
                          },
                          shape: const CircleBorder(),
                          fillColor: whiteColor,
                          child: controller.loader == 1
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: orangeColor),
                                )
                              : Icon(Icons.play_arrow,
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
                                    onPressed: () => controller.watch()),
                                CustomText(
                                  text: controller.model.isError == true
                                      ? '0.0'
                                      : controller.model.voteAverage!
                                          .toStringAsFixed(1),
                                  // controller.detales.voteAverage!
                                  //     .toStringAsFixed(1)

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
                                Container(
                                  child: GestureDetector(
                                    onTap: () => controller.favouriteUpload(),
                                    child: controller.heart == 0
                                        ? Icon(Icons.favorite_outline,
                                            color: whiteColor,
                                            size: width * 0.08)
                                        : Icon(Icons.favorite,
                                            color: orangeColor,
                                            size: width * 0.08),
                                  ),
                                ),
                              ]),
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12),
                    child: CustomText(
                        //align: TextAlign.center,
                        text: controller.model.isError == false
                            ? controller.model.title.toString()
                            : controller.backUp.title.toString(),
                        color: whiteColor,
                        size: width * 0.055,
                        maxline: 2,
                        flow: TextOverflow.ellipsis,
                        weight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                        height: height * 0.05,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.model.genres != null
                              ? controller.model.genres!.length
                              : 3,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CustomText(
                                text: controller.model.genres == null
                                    ? 'genre'.tr
                                    : controller.model.genres![index].name,
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
                                      controller.model.isError == false
                                          ? controller.model.releaseDate
                                              .toString()
                                              .substring(0, 4)
                                          : controller.backUp.releaseDate
                                              .toString()
                                              .substring(0, 4),
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
                                      text: controller
                                                  .model.productionCountries ==
                                              null
                                          ? 'country'.tr
                                          : controller.model.originCountry != ''
                                              ? countries[controller
                                                  .model.originCountry]
                                              : controller.model
                                                  .productionCountries![0].name,
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
                                      text: controller.model.isError == false
                                          ? controller.model.isShow == false
                                              ? 'length'.tr
                                              : 'seasons'.tr
                                          : controller.backUp.isShow == false
                                              ? 'length'.tr
                                              : 'seasons'.tr,
                                      color: whiteColor,
                                      size: width * 0.04,
                                      flow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 3),
                                    CustomText(
                                      text: controller.model.isError == false
                                          ? controller.model.isShow == false
                                              ? getTimeString(controller
                                                  .model.runtime as int)
                                              : controller.model.runtime
                                                  .toString()
                                          : controller.backUp.isShow == false
                                              ? getTimeString(controller
                                                  .backUp.runtime as int)
                                              : controller.backUp.runtime
                                                  .toString(),
                                      color: orangeColor,
                                      size: width * 0.04,
                                      weight: FontWeight.bold,
                                    )
                                  ])),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SizedBox(
                      height: height * 0.13,
                      child: SingleChildScrollView(
                          child: CustomText(
                        text: controller.model.isError == false
                            ? controller.model.overview.toString()
                            : controller.backUp.overview.toString(),
                        //controller.detales.overview,
                        size: width * 0.036,
                        color: whiteColor,
                      )),
                    ),
                  ),
                  const SizedBox(height: 12),
                  controller.model.cast!.isError == false
                      ? controller.model.cast!.cast![0].id != 0
                          ? ContentScrolling(
                              color: mainColor,
                              inHeight: constraints.maxHeight * 0.12,
                              inWidth: constraints.maxHeight * 0.12,
                              paddingY: 4,
                              pageWidth: constraints.maxWidth,
                              isError: false,
                              isArrow: false,
                              isTitle: true,
                              isMovie: false,
                              isShadow: false,
                              title: 'cast'.tr,
                              fit: BoxFit.cover,
                              detales: controller.model,
                              reload: () {},
                              textColor: whiteColor,
                              isFirstPage: false,
                              height: constraints.maxHeight * 0.2,
                            )
                          : ContentScrolling(
                              isWaiting: true,
                              color: mainColor,
                              inHeight: constraints.maxHeight * 0.12,
                              inWidth: constraints.maxHeight * 0.12,
                              paddingY: 4,
                              pageWidth: constraints.maxWidth,
                              isError: false,
                              isArrow: false,
                              isTitle: true,
                              isMovie: false,
                              isShadow: false,
                              title: 'cast'.tr,
                              fit: BoxFit.contain,
                              detales: controller.model,
                              reload: () {},
                              textColor: whiteColor,
                              isFirstPage: false,
                              height: constraints.maxHeight * 0.2,
                            )
                      : ContentScrolling(
                          color: orangeColor,
                          inHeight: constraints.maxHeight * 0.12,
                          inWidth: constraints.maxHeight * 0.12,
                          paddingY: 4,
                          pageWidth: constraints.maxWidth,
                          isError: true,
                          isArrow: false,
                          isTitle: false,
                          isMovie: false,
                          isShadow: false,
                          fit: BoxFit.contain,
                          reload: () => controller.getData(controller.model),
                          textColor: whiteColor,
                          isFirstPage: false,
                          height: constraints.maxHeight * 0.2,
                        ),
                  controller.model.recomendation!.isError == false
                      ? controller.model.recomendation == null ||
                              controller.model.recomendation!.results!.isEmpty
                          ? Container()
                          : controller.model.recomendation!.results![0].id != 0
                              ? ContentScrolling(
                                  color: orangeColor,
                                  borderColor: orangeColor,
                                  inHeight: constraints.maxHeight * 0.27,
                                  inWidth: constraints.maxWidth * 0.37,
                                  paddingY: 4,
                                  pageWidth: constraints.maxWidth,
                                  borderWidth: 2,
                                  isError: false,
                                  isArrow: false,
                                  isTitle: true,
                                  isMovie: true,
                                  isShadow: true,
                                  title: 'recommendations'.tr,
                                  fit: BoxFit.cover,
                                  detales: controller.model,
                                  reload: () {},
                                  textColor: whiteColor,
                                  isFirstPage: false,
                                  height: constraints.maxHeight * 0.3,
                                )
                              : Container()
                      : Container(),
                  controller.model.isError == false
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: TextField(
                                    controller: controller.txtControlller,
                                    focusNode: controller.myFocusNode,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    cursorColor: orangeColor,
                                    style: TextStyle(
                                        color: orangeColor,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'comments'.tr,
                                      hintStyle: const TextStyle(
                                        color: orangeColor,
                                      ),
                                    ),
                                  )),
                                  controller.commentLoader == 0
                                      ? IconButton(
                                          splashRadius: 15,
                                          icon: Icon(Icons.send,
                                              color: orangeColor,
                                              size: width * 0.06),
                                          onPressed: () =>
                                              controller.uploadComment(
                                                  controller.model.id
                                                      .toString(),
                                                  controller.txtControlller.text
                                                      .trim()))
                                      : const Center(
                                          child: CircularProgressIndicator(
                                              color: orangeColor),
                                        ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(
                                color: orangeColor,
                                height: 2,
                              ),
                            ),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('Comments')
                                    .doc(controller.model.id.toString())
                                    .collection('Comments')
                                    .orderBy('timeStamp', descending: true)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: orangeColor,
                                      ),
                                    );
                                  }
                                  return Column(
                                      children: List.generate(
                                          snapshot.data!.docs.length,
                                          (index) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: secondaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: mainColor,
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: Offset(0, 0),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            (width - 16) * 0.2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: snapshot.data!
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'isPicOnline'] ==
                                                                  true
                                                              ? ImageNetwork(
                                                                  link: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index]['pic'],
                                                                  height: (width -
                                                                          16) *
                                                                      0.165,
                                                                  width: (width -
                                                                          16) *
                                                                      0.165,
                                                                  color:
                                                                      secondaryColor,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  borderColor:
                                                                      orangeColor,
                                                                  borderWidth:
                                                                      1,
                                                                  isMovie:
                                                                      false,
                                                                  isShadow:
                                                                      false,
                                                                )
                                                              : CircleContainer(
                                                                  height: (width -
                                                                          16) *
                                                                      0.165,
                                                                  width: (width -
                                                                          16) *
                                                                      0.165,
                                                                  color:
                                                                      mainColor,
                                                                  shadow: false,
                                                                  icon: Icons
                                                                      .person,
                                                                  iconColor:
                                                                      orangeColor,
                                                                  borderWidth:
                                                                      1,
                                                                  borderColor:
                                                                      orangeColor,
                                                                  isPicOk:
                                                                      false,
                                                                ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            (width - 16) * 0.8,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  RichText(
                                                                    text: TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                              text: snapshot.data!.docs[index]['userName'],
                                                                              style: TextStyle(color: orangeColor, fontSize: width * 0.045, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500)),
                                                                          const TextSpan(
                                                                              text: '  .  ',
                                                                              style: TextStyle(
                                                                                color: orangeColor,
                                                                              )),
                                                                          TextSpan(
                                                                              text: timeAgo(snapshot.data!.docs[index]['timeStamp'].toDate()),
                                                                              style: TextStyle(
                                                                                color: orangeColor,
                                                                                fontSize: width * 0.037,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ))
                                                                        ]),
                                                                  ),
                                                                   snapshot.data!.docs[index]
                                                                              [
                                                                              'userId'] ==
                                                                          controller
                                                                              .userModel
                                                                              .userId
                                                                      ? IconButton(
                                                                          splashRadius:
                                                                              15,
                                                                          icon: Icon(Icons.delete,
                                                                              color:
                                                                                  orangeColor,
                                                                              size: width *
                                                                                  0.06),
                                                                          onPressed: () => controller.deleteComment(controller.model.id.toString(), snapshot.data!.docs[index].id))
                                                                      : Container(),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        12.0),
                                                                child:
                                                                    CustomText(
                                                                  text: snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'comment'],
                                                                  color:
                                                                      whiteColor,
                                                                  size: width *
                                                                      0.045,
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          print(controller
                                                                              .uuid
                                                                              .v4());
                                                                        },
                                                                        child: Icon(
                                                                            Icons
                                                                                .thumb_up,
                                                                            color:
                                                                                orangeColor,
                                                                            size:
                                                                                width * 0.06),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 8.0),
                                                                        child:
                                                                            CustomText(
                                                                          text: snapshot
                                                                              .data!
                                                                              .docs[index]['likeCount']
                                                                              .toString(),
                                                                          color:
                                                                              whiteColor,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.03,
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {},
                                                                        child: Icon(
                                                                            Icons
                                                                                .thumb_down,
                                                                            color:
                                                                                whiteColor,
                                                                            size:
                                                                                width * 0.06),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 8.0),
                                                                        child:
                                                                            CustomText(
                                                                          text: snapshot
                                                                              .data!
                                                                              .docs[index]['dislikeCount']
                                                                              .toString(),
                                                                          color:
                                                                              whiteColor,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                              [
                                                                              'subComments']
                                                                          .isNotEmpty
                                                                      ? Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(vertical: 8.0),
                                                                          child: TextButton(
                                                                              style: TextButton.styleFrom(
                                                                                foregroundColor: orangeColor,
                                                                              ),
                                                                              onPressed: () {},
                                                                              child: CustomText(text: 'view ${snapshot.data!.docs[index]['subComments'].length} replies', color: orangeColor, size: width * 0.037)),
                                                                        )
                                                                      : Container()
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )));
                                }),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
