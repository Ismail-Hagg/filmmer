import 'dart:convert';

import 'package:filmpro/local_storage/user_data_pref.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../models/user_model.dart';
import '../services/google_sign_in_service.dart';
import 'auth_controller.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  Map<String, String> head = {};
  String _res = '';
  String get res => _res;
  UserModel model = UserModel(
      userName: '',
      email: '',
      gender: '',
      onlinePicPath: '',
      localPicPath: '',
      userId: '',
      bio: '',
      birthday: {},
      isPicLocal: false,
      language: Get.deviceLocale.toString(),
      isDarkTheme: false,
      isError: true,
      phoneNumber: '',
      isSocial: false,
      messagingToken: '');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    load();
    // head = Get.find<AuthController>().headers;
  }

  // get the user data from local storage
  void load() {
    UserDataPref()
        .getUser
        .then((value) => {model = value, print(model.email), update()});
  }

  // fig() {
  //   print(Get.find<AuthController>().headers);
  //   GoogleSignInService()
  //       .googleLogIn(Get.find<AuthController>().headers, '', '', '')
  //       .then((value) => {
  //             print(value.email),
  //             print(value.gender),
  //             print(value.onlinePicPath),
  //             print(value.birthday),
  //             print(value.userName),
  //           });
  // }

  void number() {
    final SmsAutoFill _autoFill = SmsAutoFill();
    _autoFill.hint.then((value) => print('your phone number is ---  $value'));
  }

  void flipping() {
    UserModel user = UserModel(
        bio: '',
        birthday: {},
        email: '',
        gender: '',
        isDarkTheme: false,
        isError: false,
        isPicLocal: false,
        isSocial: false,
        language: '',
        localPicPath: '',
        messagingToken: '',
        onlinePicPath: '',
        phoneNumber: '',
        userId: '',
        userName: '');
        print(user.isError);
        user.isError =true;
        print(user.isError);

  }

  // thing() async {
  //   DateTime time = DateTime(2022,10,12);
  //   print(DateFormat('yyyy-MM-dd').format(time));
  //   if (Get.find<AuthController>().headers != {}) {
  //     GoogleSignInService()
  //         .googleLogIn(Get.find<AuthController>().headers)
  //         .then((value) => {
  //               _res = value,
  //               print(json.decode(value)['names'][0]['displayName']),
  //               print(json.decode(value)['photos'][0]['url']),
  //               print(json.decode(value)['genders'][0]['value']),
  //               print(json.decode(value)['birthdays'][0]['date']),
  //               print(json.decode(value)['emailAddresses'][0]['value']),
  //               // for (var val in json.decode(_res).keys)
  //               //   {
  //               //     print(val),
  //               //   },

  //               update()
  //             });
  //   } else {
  //     print('No Headers');
  //   }
  // }
}
