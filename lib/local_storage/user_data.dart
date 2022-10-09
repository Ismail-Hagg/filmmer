import 'dart:convert';
import 'dart:ui';


import 'package:filmpro/helper/constants.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

class UserData {
  // using get storage to sava user data
  final box = GetStorage();

  // saving user data
  void setUser(UserModel model) async {
    box.write(userDataKey, json.encode(model.toMap()));
  }

  // retreive user data from local storage
  UserModel _getUserData() {
    var value = box.read(userDataKey); 
    return UserModel.fromMap(json.decode(value.toString()));
  }

  UserModel get getUser {
    try {
      UserModel model = _getUserData(); 
      return model;
    } catch (e) {
      return UserModel(
          age: 0,
          bio: '',
          email: '',
          gender: '',
          isDarkTheme: false,
          isPicLocal: false,
          language: {},
          localPicPath: '',
          onlinePicPath: '',
          userId: '',
          userName: '',
          isError: true,
          phoneNumber: '');
    }
  }
  
  // delete user data from local storage
  void deleteUser()async {
   box.remove(userDataKey);
  }
}
