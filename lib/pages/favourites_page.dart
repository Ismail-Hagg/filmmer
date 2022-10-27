import 'package:filmpro/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/favourites_controller.dart';
import '../helper/constants.dart';
import '../widgets/custom_text.dart';

class FavouritesPage extends StatelessWidget {
  FavouritesPage({Key? key}) : super(key: key);

  final FavouritesController controller = Get.put(FavouritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          title: CustomText(
            text: 'favourite'.tr,
            color: orangeColor,
            
          ),
          actions: [
            IconButton(
              icon: GetBuilder<FavouritesController>(
                init: Get.find<FavouritesController>(),
                builder: (controller) => CustomText(
                  color: whiteColor,
                  text: controller.newList.length.toString(),
                ),
              ),
              onPressed: null,
            ),
            IconButton(
              icon: const Icon(Icons.search),
              splashRadius: 15,
              onPressed: () {
                Get.to(()=>SearchPage(list: controller.newList));
              },
            ),
            IconButton(
              icon: const Icon(Icons.shuffle),
              splashRadius: 15,
              onPressed: () {
                Get.find<FavouritesController>().randomnav();
              },
            ),
            
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          var height = constraints.maxHeight;
          var width = constraints.maxWidth;

          return GetBuilder<FavouritesController>(
            init: Get.find<FavouritesController>(),
            builder: (controller) => Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: Get.find<FavouritesController>().newList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        splashRadius: 15,
                        onPressed: () {
                           controller.localDelete(
                               controller.newList[index].id, index,controller.newList[index]);
                        },
                      ),
                      title: CustomText(
                        text: controller.newList[index].name,
                        color: whiteColor,
                        size: width * 0.045
                      ),
                      onTap: () {
                         controller.navv(controller.newList[index]);
                      });
                },
              ),
            ),
          );
        }));
  }
}
