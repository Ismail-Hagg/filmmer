
import 'package:filmpro/pages/controller_page.dart';
import 'package:filmpro/services/theme_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/auth_controller.dart';
import 'firebase_options.dart';
import 'helper/translation.dart';
import 'local_storage/user_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(AuthController());
  runApp(MyApp(
    map: UserData().getUser.language,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, String> map;
  const MyApp({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme:ThemeService().lightTheme,
      darkTheme: ThemeService().darkTheme,
      themeMode: ThemeService().getThemeMode(),
      fallbackLocale: Get.deviceLocale,
      locale: Locale(map['lan'].toString(), map['con'].toString()),
      debugShowCheckedModeBanner: false,
      title: 'Filmmer',
      translations: Translation(),
      home: const ControllerPage(),
    );
  }
}
