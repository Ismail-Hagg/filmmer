import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_more_controller.dart';
import '../helper/constants.dart';
import '../widgets/custom_text.dart';
import '../widgets/network_image.dart';

class SearchMorePage extends StatelessWidget {
  SearchMorePage({Key? key}) : super(key: key);
  final SearchMorePageController controller =
      Get.put(SearchMorePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainColor,
      appBar: controller.move.isSearch == true
          ? AppBar(
              backgroundColor: mainColor,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                      focusNode: controller.myFocusNode,
                      controller: controller.txt,
                      cursorColor: orangeColor,
                      autofocus: true,
                      style:  TextStyle(color: orangeColor,fontSize:MediaQuery.of(context).size.width*0.045),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'search'.tr,
                        hintStyle: const TextStyle(
                          color: orangeColor,
                        ),
                      ),
                      onSubmitted: (val) {
                        if (val.trim() != '') {
                          controller.searchReady(val);
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clearFocus();
                    },
                    splashRadius: 15,
                  ),
                  GetBuilder<SearchMorePageController>(
                      init: Get.find<SearchMorePageController>(),
                      builder: (builder) => builder.pageLoad == 1
                          ? const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: orangeColor,
                                ),
                              ),
                            )
                          : Container())
                ],
              ))
          : AppBar(
              elevation: 0,
              backgroundColor: mainColor,
              centerTitle: true,
              title: CustomText(
                  text: controller.move.title,
                  color: orangeColor,
                  size: MediaQuery.of(context).size.width * 0.045),
              actions: [
                GetBuilder<SearchMorePageController>(
                    init: Get.find<SearchMorePageController>(),
                    builder: (builder) => builder.pageLoad == 1
                        ? const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: orangeColor,
                              ),
                            ),
                          )
                        : Container())
              ],
            ),
      body: GetBuilder<SearchMorePageController>(
        init: Get.find<SearchMorePageController>(),
        builder: (builder) => LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return builder.indicator == 1
              ? const Center(
                  child: CircularProgressIndicator(
                  color: orangeColor,
                ))
              : builder.model.results == null
                  ? Container()
                  : builder.model.isError == true
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: builder.model.errorMessage,
                              color: orangeColor,
                              size: constraints.maxWidth * 0.05,
                              flow: TextOverflow.visible,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  controller.searchReady(controller.query),
                              child: Icon(
                                Icons.refresh,
                                color: orangeColor,
                                size: constraints.maxWidth * 0.25,
                              ),
                            ),
                          ],
                        ))
                        
                      : 
                      builder.model.totalResults == 0?
                             Center(
                                child: CustomText(
                                  text: 'res'.tr,
                                  size: constraints.maxWidth * 0.05,
                                  color: orangeColor,
                                ),
                              ):
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Expanded(
                            child: SingleChildScrollView(
                                controller: builder.scrollController,
                                physics: const BouncingScrollPhysics(),
                                child: Column(children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      spacing: 2,
                                      runSpacing: 2,
                                      children: List.generate(
                                          builder.model.results!.length, (index) {
                                        return GestureDetector(
                                          onTap: () =>builder.navToDetale(builder.model.results![index]),
                                          child: ImageNetwork(
                                            borderWidth: 2,
                                            borderColor: orangeColor,
                                            rating: builder
                                                .model.results?[index].voteAverage
                                                .toString(),
                                            link: imagebase +
                                                (builder.model.results?[index]
                                                        .posterPath)
                                                    .toString(),
                                            height: constraints.maxHeight * 0.3,
                                            width: constraints.maxWidth * 0.323,
                                            isMovie: true,
                                            isShadow: false,
                                            color: orangeColor,
                                            fit: BoxFit.contain,
                                          ),
                                        );
                                      }))
                                ]))),
                      );

          //  return

          //    builder.indicator == 1
          //       ? const Center(
          //           child: CircularProgressIndicator(
          //           color: orangeColor,
          //         )):
          //         builder.model.results==null?
          //  Container()
          //           : builder.model.isError == true
          //               ? Center(
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       CustomText(
          //                       text: builder.model.errorMessage,
          //                       color: orangeColor,
          //                       size: constraints.maxWidth * 0.05,
          //                       flow: TextOverflow.visible,
          //                     ),
          //                       GestureDetector(
          //                       onTap: () =>controller.searchReady(controller.query),
          //                       child: Icon(
          //                         Icons.refresh,
          //                         color: orangeColor,
          //                         size: constraints.maxWidth * 0.25,
          //                       ),
          //                 ),
          //                     ],
          //                   ))
          //               : builder.model.totalResults == 0
          //                   ? Center(
          //                       child: CustomText(
          //                         text: 'res'.tr,
          //                         size: constraints.maxWidth * 0.05,
          //                         color: orangeColor,
          //                       ),
          //                     )

          //                   : Expanded(
          //                       child: SingleChildScrollView(
          //                           controller: builder.scrollController,
          //                           physics: const BouncingScrollPhysics(),
          //                           child: Column(
          //                             children: [
          //                               Wrap(
          //                                   direction: Axis.horizontal,
          //                                   spacing: 2,
          //                                   runSpacing: 2,
          //                                   children: List.generate(
          //                                       builder.model.results!.length,
          //                                       (index) {
          //                                     return ImageNetwork(
          //                                       borderWidth: 2,
          //                                       borderColor: orangeColor,
          //                                       rating: builder.model
          //                                           .results?[index].voteAverage
          //                                           .toString(),
          //                                       link: imagebase +
          //                                           (builder.model.results?[index]
          //                                                   .posterPath)
          //                                               .toString(),
          //                                       height:
          //                                           constraints.maxHeight * 0.3,
          //                                       width:
          //                                           constraints.maxWidth * 0.329,
          //                                       isMovie: true,
          //                                       isShadow: false,
          //                                       color: orangeColor,
          //                                       fit: BoxFit.contain,
          //                                     );
          //                                   })),
          //                               builder.pageLoad == 1
          //                                   ? const Padding(
          //                                       padding: EdgeInsets.all(12.0),
          //                                       child: Center(
          //                                         child:
          //                                             CircularProgressIndicator(
          //                                           // backgroundColor: mainColor,
          //                                           color: orangeColor,
          //                                         ),
          //                                       ),
          //                                     )
          //                                   : Container()
          //                             ],
          //                           )),
          //                     );
        }),
      ),
    );
  }
}
