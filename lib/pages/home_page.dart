import 'package:filmpro/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
           IconButton(
            icon: const Icon(Icons.nightlife),
            onPressed: () =>ThemeService().changeTheme(),
          )
        ],
      ),
      body:Center(child: GestureDetector( onTap: (){ 
        Get.find<AuthController>().signOut();
      }, child: Text('Home Page',style:TextStyle(color: ThemeService().lightTheme.primaryColor))))
    );
  }
} 