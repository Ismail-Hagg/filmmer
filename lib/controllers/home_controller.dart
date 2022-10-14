import 'dart:io';
import 'package:filmpro/local_storage/user_data_pref.dart';
import 'package:get/get.dart';
import '../helper/utils.dart';
import '../models/user_model.dart';
import '../services/firebase_storage_service.dart';
import '../services/firestore_service.dart';

class HomeController extends GetxController {
  Map<String, String> head = {};
  UserModel get model => _model;
  UserModel _model = UserModel(
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
      messagingToken: '',
      headAuth: '',
      headOther: '');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    load();
    // head = Get.find<AuthController>().headers;
  }

  // get the user data from local storage
  void load() {
    UserDataPref().getUser.then((value) => {
          _model = value,
          update(),
          uploadImage(),
        });
  }

  // upload profile image to firebase storage
  void uploadImage() async {
    int count = 1;
    if (model.isPicLocal == true && model.onlinePicPath == '') {
      FirebaseStorageService()
          .uploade(model.userId, File(model.localPicPath))
          .then((value) => {
                model.onlinePicPath = value,
                UserDataPref().setUser(model),
                FirestoreService()
                    .updateData(model.userId, 'onlinePicPath', value)
              })
          .catchError((e) {
        if (count <= 2) {
          load();
          count++;
        } else {
          snack('error'.tr, 'imageerror'.tr);
        }
      });
    }
  }
}
