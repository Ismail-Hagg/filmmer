

import 'package:flutter/material.dart';
import 'package:get/get.dart';



// show a snackbar with a message
void snack(String message, String otherMessage) {
  Get.snackbar(message, otherMessage,
      margin: const EdgeInsets.all(0),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black38,
      borderRadius: 0,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white);
} 


// firebase error messages
String getMessageFromErrorCode(e) {
    switch (e.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "firealready".tr;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "firewrong".tr;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "fireuser".tr;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "firedis".tr;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "fireserver".tr;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "fireemail".tr;
      default:
        return "firelogin".tr;
    }
  }

  // age calculation
  int calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}