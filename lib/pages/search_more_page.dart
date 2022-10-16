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
                      style: const TextStyle(color: orangeColor),
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
                  )
                ],
              ))
          : AppBar(
              elevation: 0,
              backgroundColor: mainColor,
              centerTitle: true,
              title: CustomText(
                  text: controller.move.title,
                  color: orangeColor,
                  size: MediaQuery.of(context).size.width * 0.045)),
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
                          child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.refresh,
                            color: orangeColor,
                            size: constraints.maxWidth * 0.4,
                          ),
                        ))
                      : 
                      // Container(
                      //     height: constraints.maxHeight,
                      //     child: GridView.count(
                      //         primary: false,
                      //         padding: const EdgeInsets.all(12),
                      //         crossAxisSpacing: 2,
                      //         mainAxisSpacing: 2,
                      //         crossAxisCount: 3,
                      //         children: List.generate(
                      //             builder.model.results!.length, (index) {
                      //           return ImageNetwork(
                      //             borderWidth: 2,
                      //             borderColor: orangeColor,
                      //             rating: builder
                      //                 .model.results?[index].voteAverage
                      //                 .toString(),
                      //             link: imagebase +
                      //                 (builder.model.results?[index].posterPath)
                      //                     .toString(),
                      //             height: constraints.maxHeight,
                      //             width: constraints.maxWidth,
                      //             isMovie: true,
                      //             isShadow: false,
                      //             color: orangeColor,
                      //             fit: BoxFit.contain,
                      //           );
                      //         })));
                      Expanded(
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 2,
                            runSpacing: 2,
                            children: List.generate(
                                builder.model.results!.length, (index) {
                               return ImageNetwork(
                                  borderWidth: 2,
                                  borderColor: orangeColor,
                                  rating: builder
                                      .model.results?[index].voteAverage
                                      .toString(),
                                  link: imagebase +
                                      (builder.model.results?[index].posterPath)
                                          .toString(),
                                  height: constraints.maxHeight*0.3,
                                  width: constraints.maxWidth*0.329,
                                  isMovie: true,
                                  isShadow: false,
                                  color: orangeColor,
                                  fit: BoxFit.contain,
                                );
                            }))),
                  );
        }),
      ),
    );
  }
}
