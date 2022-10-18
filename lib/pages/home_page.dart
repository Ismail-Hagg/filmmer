import 'package:filmpro/widgets/content_scrolll.dart';
import 'package:filmpro/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../helper/constants.dart';
import '../widgets/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                Get.find<HomeController>().goToSearch(true, '', '');
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
                        SizedBox(
                          height: constraints.maxWidth * 0.016,
                        ),
                        ContentScrolling(
                          color: orangeColor,
                          borderColor: orangeColor,
                          inHeight: constraints.maxHeight * 0.3,
                          inWidth: constraints.maxWidth * 0.37,
                          paddingY: 8,
                          pageWidth: constraints.maxWidth,
                          borderWidth: 2,
                          isError: controller.upcomingMovies.isError as bool,
                          isArrow: true,
                          isTitle: true,
                          isMovie: true,
                          isShadow: false,
                          title: 'upcoming'.tr,
                          fit: BoxFit.cover,
                          reload: () =>Get.find<HomeController>().apiCall(Get.find<HomeController>().model.language),
                          textColor: whiteColor,
                          isFirstPage: true,
                          height: constraints.maxHeight * 0.31,
                          model: controller.upcomingMovies,
                          link: upcoming,
                        ),
                        ContentScrolling(
                          color: orangeColor,
                          borderColor: orangeColor,
                          inHeight: constraints.maxHeight * 0.3,
                          inWidth: constraints.maxWidth * 0.37,
                          paddingY: 8,
                          pageWidth: constraints.maxWidth,
                          borderWidth: 2,
                          isError: controller.popularMovies.isError as bool,
                          isArrow: true,
                          isTitle: true,
                          isMovie: true,
                          isShadow: false,
                          title: 'popularMovies'.tr,
                          fit: BoxFit.cover,
                          reload: () =>Get.find<HomeController>().apiCall(Get.find<HomeController>().model.language),
                          textColor: whiteColor,
                          isFirstPage: true,
                          height: constraints.maxHeight * 0.31,
                          model:controller.popularMovies,
                          link: pop,
                        ),
                        ContentScrolling(
                          color: orangeColor,
                          borderColor: orangeColor,
                          inHeight: constraints.maxHeight * 0.3,
                          inWidth: constraints.maxWidth * 0.37,
                          paddingY: 8,
                          pageWidth: constraints.maxWidth,
                          borderWidth: 2,
                          isError: controller.popularShows.isError as bool,
                          isArrow: true,
                          isTitle: true,
                          isMovie: true,
                          isShadow: false,
                          title: 'popularShows'.tr,
                          fit: BoxFit.cover,
                          reload: () =>Get.find<HomeController>().apiCall(Get.find<HomeController>().model.language),
                          textColor: whiteColor,
                          isFirstPage: true,
                          height: constraints.maxHeight * 0.31,
                          model: controller.popularShows,
                          link: popularTv
                        ),
                        ContentScrolling(
                          color: orangeColor,
                          borderColor: orangeColor,
                          inHeight: constraints.maxHeight * 0.3,
                          inWidth: constraints.maxWidth * 0.37,
                          paddingY: 8,
                          pageWidth: constraints.maxWidth,
                          borderWidth: 2,
                          isError: controller.topMovies.isError as bool,
                          isArrow: true,
                          isTitle: true,
                          isMovie: true,
                          isShadow: false,
                          title: 'topMovies'.tr,
                          fit: BoxFit.cover,
                          reload: () =>Get.find<HomeController>().apiCall(Get.find<HomeController>().model.language),
                          textColor: whiteColor,
                          isFirstPage: true,
                          height: constraints.maxHeight * 0.31,
                          model: controller.topMovies,
                          link: top,
                        ),
                        ContentScrolling(
                          color: orangeColor,
                          borderColor: orangeColor,
                          inHeight: constraints.maxHeight * 0.3,
                          inWidth: constraints.maxWidth * 0.37,
                          paddingY: 8,
                          pageWidth: constraints.maxWidth,
                          borderWidth: 2,
                          isError: controller.topShows.isError as bool,
                          isArrow: true,
                          isTitle: true,
                          isMovie: true,
                          isShadow: false,
                          title: 'topShowa'.tr,
                          fit: BoxFit.cover,
                          reload: () =>Get.find<HomeController>().apiCall(Get.find<HomeController>().model.language),
                          textColor: whiteColor,
                          isFirstPage: true,
                          height: constraints.maxHeight * 0.31,
                          model: controller.topShows,
                          link: topTv,
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
