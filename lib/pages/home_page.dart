import 'package:filmpro/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../helper/constants.dart';
import '../widgets/content_scroll.dart';
import '../widgets/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        drawer: Draw(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColor,
          centerTitle: true,
          title: Shimmer.fromColors(
              period: const Duration(seconds: 3),
              baseColor: orangeColor,
              highlightColor: Colors.yellow,
              child: const CustomText(
                text: 'Filmmer',
                size: 26,
                color: orangeColor,
              )),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              splashRadius: 15,
              onPressed: () {
                Get.find<HomeController>()
                              .goToSearch(true, '', '');
              },
            ),
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return MixinBuilder<HomeController>(
              init: Get.find<HomeController>(),
              builder: (builder) => builder.count.value == 0
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                         SizedBox(height: constraints.maxWidth * 0.016,),
                        ContentScroll( 
                          borderColor: orangeColor,
                          borderWidth:2,
                          model: controller.upcomingMovies,
                          isArrow: true,
                          isMovie: true,
                          paddingY: 8,
                          title: 'upcoming'.tr,
                          size: constraints.maxWidth * 0.057,
                          color: orangeColor,
                          iconSize: constraints.maxWidth * 0.06,
                          height: constraints.maxHeight * 0.31,
                          picHeight: constraints.maxHeight * 0.3,
                          picWidth: constraints.maxWidth * 0.37,
                          link: upcoming,
                        ),
                        ContentScroll(
                          borderColor: orangeColor,
                          borderWidth:2,
                          model: controller.popularMovies,
                          isArrow: true,
                          isMovie: true,
                          paddingY: 8,
                          title: 'popularMovies'.tr,
                          size: constraints.maxWidth * 0.057,
                          color: orangeColor,
                          iconSize: constraints.maxWidth * 0.06,
                          height: constraints.maxHeight * 0.31,
                          picHeight: constraints.maxHeight * 0.3,
                          picWidth: constraints.maxWidth * 0.37,
                          link: pop,
                        ),
                        ContentScroll(
                          borderColor: orangeColor,
                          borderWidth:2,
                          model: controller.popularShows,
                          isArrow: true,
                          isMovie: true,
                          paddingY: 8,
                          title: 'popularShows'.tr,
                          size: constraints.maxWidth * 0.057,
                          color: orangeColor,
                          iconSize: constraints.maxWidth * 0.06,
                          height: constraints.maxHeight * 0.31,
                          picHeight: constraints.maxHeight * 0.3,
                          picWidth: constraints.maxWidth * 0.37,
                          link:popularTv
                        ),
                        ContentScroll(
                          borderColor: orangeColor,
                          borderWidth:2,
                          model: controller.topMovies,
                          isArrow: true,
                          isMovie: true,
                          paddingY: 8,
                          title: 'topMovies'.tr,
                          size: constraints.maxWidth * 0.057,
                          color: orangeColor,
                          iconSize: constraints.maxWidth * 0.06,
                          height: constraints.maxHeight * 0.31,
                          picHeight: constraints.maxHeight * 0.3,
                          picWidth: constraints.maxWidth * 0.37,
                          link: top,
                        ),
                        ContentScroll(
                          borderColor: orangeColor,
                          borderWidth:2,
                          model: controller.topShows,
                          isArrow: true,
                          isMovie: true,
                          paddingY: 8,
                          title: 'topShowa'.tr,
                          size: constraints.maxWidth * 0.057,
                          color: orangeColor,
                          iconSize: constraints.maxWidth * 0.06,
                          height: constraints.maxHeight * 0.31,
                          picHeight: constraints.maxHeight * 0.3,
                          picWidth: constraints.maxWidth * 0.37,
                          link:topTv,
                        ),
                      ]),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                      color: orangeColor,
                    )));
        }));
  }
}
