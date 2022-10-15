import 'package:filmpro/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../helper/constants.dart';
import '../widgets/content_scroll.dart';
import '../widgets/network_image.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());
  List<String> lst = [
    'https://images.unsplash.com/photo-1664574654561-4c54605b1372?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
    'https://images.unsplash.com/photo-1665672809651-229a937f4677?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1126&q=80',
    'https://images.unsplash.com/photo-1665673134862-62cf0ef3e729?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
    'https://images.unsplash.com/photo-1665672051874-a1d1541b452c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
    'https://images.unsplash.com/photo-1665772484481-954badfa217b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1665750289246-f526d410f260?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1976&q=80',
    'https://images.unsplash.com/photo-1665501341082-2367dd99328e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
    'https://images.unsplash.com/photo-1657214058744-7ff3b448c205?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=736&q=80',
    'https://images.unsplash.com/photo-1665834739827-5e03d5f520aa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1632&q=80',
    'https://images.unsplash.com/photo-1665739049894-9fc02bc728de?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
    'https://images.unsplash.com/photo-1665737048684-71efb65c55a4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        drawer: const Drawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColor,
          centerTitle: true,
          title: const CustomText(
            text: 'Filmmer',
            size: 26,
            color: orangeColor,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              splashRadius: 15,
              onPressed: () {
                //controller.test();
              },
            )
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
                        ContentScroll(
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
                          links: lst,
                        ),
                        ContentScroll(
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
                          links: lst,
                        ),
                        ContentScroll(
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
                          links: lst,
                        ),
                        ContentScroll(
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
                          links: lst,
                        ),
                        ContentScroll(
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
                          links: lst,
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
