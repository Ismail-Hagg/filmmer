import 'package:filmpro/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../helper/constants.dart';
import '../widgets/circle_container.dart';
import '../widgets/network_image.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            GestureDetector(
              onTap: ()=>Get.find<AuthController>().signOut(),
              child:const  ImageNetwork(
                color: orangeColor,
                fit: BoxFit.contain,
                height: 200,
                isMovie: true,
                link: 'https://images.unsplash.com/photo-1665582844012-33aa8b2c3d8d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                width: 150,
              ),
            )
          ],
        )));
  }
}
