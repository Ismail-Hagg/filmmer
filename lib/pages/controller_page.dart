import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controllers/auth_controller.dart';
import 'home_page.dart';
import 'login_page.dart';



// decide if user is logged in or not 

class ControllerPage extends StatelessWidget {
  const ControllerPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: Get.find<AuthController>(),
      builder: (controller) => controller.user == null ?  LoginPage() :const HomePage(),
    );
  }
}