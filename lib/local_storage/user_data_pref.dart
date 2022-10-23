import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/constants.dart';
import '../models/user_model.dart';

class UserDataPref { 
  Future<UserModel> get getUser async {
    try {
      UserModel model = await _getUserData();
      return model;
    } catch (e) {
      print(e.toString());
      return UserModel(
          birthday: {},
          bio: '',
          email: 'Email',
          gender: '',
          isDarkTheme: false,
          isError: true,
          isPicLocal: false,
          isSocial: false,
          language: Get.deviceLocale.toString(),
          localPicPath: '',
          messagingToken: '',
          onlinePicPath: '',
          phoneNumber: '',
          userId: '',
          userName: 'Username',
          headAuth: '',
          headOther: '',
          commentLikes: '',
      commentsDislikes: '',
          );
    }
  }

  setUser(UserModel model) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(userDataKey, json.encode(model.toMap())).then((value) => print('Saved Successfully'));
  }

  

  Future<UserModel> _getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getString(userDataKey);

    return UserModel.fromMap(json.decode(value.toString()));
  }

  Future<void> deleteUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
