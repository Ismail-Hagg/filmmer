

import 'package:filmpro/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

const userDataKey = 'userDataKey';


void snack(String message, String otherMessage) {
  Get.snackbar(message, otherMessage,
      margin: const EdgeInsets.all(0),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.black38,
      borderRadius: 0,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white);
} 