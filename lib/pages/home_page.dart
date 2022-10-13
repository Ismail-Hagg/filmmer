import 'package:filmpro/local_storage/user_data_pref.dart';
import 'package:filmpro/services/theme_service.dart';
import 'package:filmpro/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../models/user_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton( 
                icon: const Icon(Icons.nightlife),
                //onPressed: () =>ThemeService().changeTheme(),
                onPressed: () {
                  Get.find<AuthController>().signOut();
                  //print(UserData().getUser.email);
                  //UserModel.fromMap(json.decode(UserData().box.read(userDataKey)));
                }),
                //  IconButton(
                // icon: const Icon(Icons.face),
                // onPressed: () {
                //   controller.fig();
                // }),
                IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                 // controller.thing();
                })
          ],
        ),
        body: Center(
            child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            GetBuilder<HomeController>(
              init:Get.find<HomeController>(),
              builder:(controller)=> Column(
                children: [
                  CustomText(text: 'error : ${controller.model.isError.toString()}',color: Colors.red,), 
                  CustomText(text: 'phone : ${controller.model.phoneNumber}',color: Colors.red,), 
                  Container(
                    height: MediaQuery.of(context).size.height-200,
                      child: SingleChildScrollView(
                          child: CustomText(
                            color: Colors.black, 
                    text: controller.res,
                  ))),
                ],
              ),
            )
          ], 
        )));
  }
}
