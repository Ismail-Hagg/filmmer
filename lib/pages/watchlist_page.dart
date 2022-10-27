import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/watchlist_controller.dart';
import '../helper/constants.dart';
import '../widgets/custom_text.dart';

class WatchlistPage extends StatelessWidget {
  WatchlistPage({super.key});

  final WatchlistController controll = Get.put(WatchlistController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        title: CustomText(
          text: 'watchList'.tr,
          color: orangeColor,
          size: size.width * 0.05,
        ),
        actions: [
          GetBuilder<WatchlistController>(
            init: Get.find<WatchlistController>(),
            builder: (bro) => IconButton(
              icon: CustomText(
                text: Get.find<WatchlistController>().count == 0
                    ? Get.find<WatchlistController>()
                        .movieList
                        .length
                        .toString()
                    : Get.find<WatchlistController>()
                        .showList
                        .length
                        .toString(),
                size: size.width * 0.04,
              ),
              onPressed: null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            splashRadius: 15,
            onPressed: () {
              controll.searching();
            },
          ),
          IconButton(
            icon: const Icon(Icons.shuffle),
            splashRadius: 15,
            onPressed: () {
              controll.randomNav();
            },
          ),
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var height = constraints.maxHeight;
        var width = constraints.maxWidth;
        return GetBuilder<WatchlistController>(
          init: Get.find<WatchlistController>(),
          builder: (builder) => Column(
            children: [
              Container(
                height: height * 0.07,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: height * 0.067,
                          child: InkWell(
                            onTap: () {
                              builder.change(0);
                            },
                            child: SizedBox(
                              width: width * 0.5,
                              child: Center(
                                child: CustomText(
                                  text: 'movies'.tr,
                                  color: builder.count == 0
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.3),
                                  size: width * 0.04,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.003,
                          color: builder.count == 0
                              ? orangeColor
                              : Colors.transparent,
                          width: width * 0.5,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: height * 0.067,
                          child: InkWell(
                            onTap: () {
                              builder.change(1);
                            },
                            child: SizedBox(
                              width: width * 0.5,
                              child: Center(
                                child: CustomText(
                                  text: 'shows'.tr,
                                  color: builder.count == 1
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.3),
                                  size: width * 0.04,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.003,
                          color: builder.count == 1
                              ? orangeColor
                              : Colors.transparent,
                          width: width * 0.5,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  height: height * 0.93,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: builder.count == 0
                          ? builder.movieList.length
                          : builder.showList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            builder.navv(builder.count == 0
                                  ? builder.movieList[index]
                                  : builder.showList[index]);
                          },
                          title: CustomText(
                              text: builder.count == 0
                                  ? builder.movieList[index].name
                                  : builder.showList[index].name,
                              color: Colors.white,
                              size: width * 0.042),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            splashRadius: 15,
                            onPressed: () {
                              builder.delete(index);
                            },
                          ),
                        );
                      },
                    ),
                  ))
            ],
          ),
        );
      }),
    );
  }
}
