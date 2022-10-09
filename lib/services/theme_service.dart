import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  // themes

  final lightTheme = ThemeData.light().copyWith(
    // primaryColor: const Color.fromRGBO(48, 48, 48, 1),
    // hoverColor: const Color.fromRGBO(238, 141, 51, 1),
    // canvasColor: const Color.fromRGBO(55, 56, 62, 1),
    colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary:  Color.fromRGBO(238, 141, 51, 1),
          onPrimary: Colors.white,
          secondary:  Color.fromRGBO(48, 48, 48, 1),
          onSecondary: Colors.white70,
          error: Colors.red,
          onError: Colors.red,
          background:  Color.fromARGB(255, 91, 91, 94),
          onBackground: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black54)
  );

  final darkTheme = ThemeData.dark().copyWith(
      // primaryColor: const Color.fromRGBO(48, 48, 48, 1),
      // hoverColor: const Color.fromRGBO(238, 141, 51, 1),
      // canvasColor: const Color.fromARGB(255, 91, 91, 94),
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary:  Color.fromRGBO(238, 141, 51, 1),
          onPrimary: Colors.white,
          secondary:  Color.fromRGBO(48, 48, 48, 1),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.red,
          background:  Color.fromARGB(255, 91, 91, 94),
          onBackground: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black54));

  final _themeStore = GetStorage();
  final _darkThemeKey = 'isDarkTheme';

  void saveThemeData(bool isDarkTheme) {
    _themeStore.write(_darkThemeKey, isDarkTheme);
  }

  bool isSavedDarkMode() {
    return _themeStore.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }
}
