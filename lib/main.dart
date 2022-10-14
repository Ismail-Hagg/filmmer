import 'package:filmpro/local_storage/user_data_pref.dart';
import 'package:filmpro/pages/controller_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; 
import 'controllers/auth_controller.dart';
import 'firebase_options.dart';
import 'helper/translation.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(AuthController());
  UserDataPref().getUser.then((value) => {
    value.isError? runApp(MyApp(locale: Get.deviceLocale.toString())):runApp(MyApp(locale: value.language))
  });
}

class MyApp extends StatelessWidget { 
  final String locale;
  const MyApp({Key? key, required this.locale}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      fallbackLocale: Locale(Get.deviceLocale.toString()),
      locale: Locale(locale),
      debugShowCheckedModeBanner: false,
      title: 'Filmmer',
      translations: Translation(),
      home: const ControllerPage(),
    );
  }
}
