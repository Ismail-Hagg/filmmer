import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filmpro/controllers/home_controller.dart';
import 'package:filmpro/local_storage/user_data_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../helper/utils.dart';
import '../models/user_model.dart';
import '../pages/controller_page.dart';
import '../services/firestore_service.dart';
import '../services/google_sign_in_service.dart';

class AuthController extends GetxController {
  final Rxn<User> _user = Rxn<User>();
  User? get user => _user.value;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn get google => _googleSignIn;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/contacts.readonly',
    'https://www.googleapis.com/auth/user.birthday.read',
    'https://www.googleapis.com/auth/userinfo.profile',
    'https://www.googleapis.com/auth/user.gender.read',
    'https://www.googleapis.com/auth/user.phonenumbers.read',
  ]);


  final _count = 0.obs;
  final _obscure = true.obs;

  RxInt get count => _count;
  RxBool get obcure => _obscure;

  File _image = File('');
  File get image => _image;
  String _path = '';
  String get path => _path;
  bool _isPicked = false;
  bool get isPicked => _isPicked;

  String _name = '';
  String _email = '';
  String _password = '';

  Map<String, String> thing={};

  late FirebaseMessaging token;

  final SmsAutoFill _autoFill = SmsAutoFill();

  // the onInint function runs when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    update();
  }

  // get user phone number
  void getNumbers(context) {
    _autoFill.hint
        .then((value) => googleSignInMethod(context, value.toString()));
  }

  // sign in with google
  void googleSignInMethod(context, String number) async {
    FocusScope.of(context).unfocus();
    count.value = 1;
    try {
      final dynamic googleUser = await _googleSignIn.signIn() ?? '';
      if (googleUser == '') {
        snack('abort'.tr, '');

        count.value = 0;
      } else {
        GoogleSignInAuthentication authy = await googleUser!.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: authy.idToken, accessToken: authy.accessToken);

        await _auth.signInWithCredential(credential).then((user) async => {
              FirestoreService()
                  .getCurrentUser(user.user!.uid)
                  .then((value) => {
                        if (value.data() == null)
                          {
                            // first time logging in with google account
                            _googleSignIn.currentUser?.authHeaders
                                .then((head) => {
                                  thing=head,
                                      GoogleSignInService()
                                          .googleLogIn(
                                              head,
                                              user.user!.uid.toString(),
                                              '',
                                              number)
                                          .then((value) => {
                                                if (value.isError)
                                                  {
                                                    snack(
                                                        'error'.tr,
                                                        getMessageFromErrorCode(
                                                            ''))
                                                  }
                                                else
                                                  {
                                                    FirebaseMessaging.instance
                                                        .getToken()
                                                        .then((token) => {
                                                              value.messagingToken =
                                                                  token
                                                                      .toString(),
                                                                      // value.googleHeaders=head,
                                                                      value.headAuth=head['Authorization'].toString(),
                                                                      value.headOther=head['X-Goog-AuthUser'].toString(),
                                                              saveDataFirebase(
                                                                  model: value),
                                                              Get.offAll(() =>
                                                                  const ControllerPage()),
                                                              count.value = 0,
                                                            })
                                                        .catchError((e) {
                                                      value.messagingToken = '';
                                                      saveDataFirebase(
                                                          model: value);
                                                      Get.offAll(() =>
                                                          const ControllerPage());
                                                      count.value = 0;
                                                    })
                                                  }
                                              })
                                          .catchError((e) {
                                        snack('error'.tr,
                                            getMessageFromErrorCode(e));
                                      })
                                    })
                                .catchError((e) {
                              snack('error'.tr, getMessageFromErrorCode(e));
                            })
                          }
                        else
                          {
                            // logged with a google account before
                            saveDataLocal(UserModel.fromMap(
                                value.data() as Map<dynamic, dynamic>)),
                            // getDocs(user.user!.uid);
                            Get.offAll(() => const ControllerPage()),
                            count.value = 0
                          }
                      })
                  .catchError((e) {
                snack('error'.tr, getMessageFromErrorCode(e));
              })
            });
      }
    } on FirebaseAuthException catch (e) {
      snack('error'.tr, getMessageFromErrorCode(e));

      count.value = 0;
    } catch (e) {
      snack('error'.tr, e.toString());
      count.value = 0;
    }
  }

  //signup with email and Password
  Future<void> register(BuildContext context) async {
    FocusScope.of(context).unfocus();
    count.value = 1;
    if (_name == '') {
      snack('adduser'.tr, '');
      count.value = 0;
    } else {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .then((user) async => {
                      await FirebaseMessaging.instance
                          .getToken()
                          .then((token) => {
                                _autoFill.hint.then((number) => {
                                      saveDataFirebase(
                                        user: user,
                                        google: false,
                                        onlinePicPath: '',
                                        token: token.toString(),
                                        number: number.toString(),
                                        
                                      ),
                                      Get.offAll(() => const ControllerPage()),
                                      count.value = 0
                                    })
                              })
                });
      } on FirebaseAuthException catch (i) {
        snack('error'.tr, getMessageFromErrorCode(i));

        count.value = 0;
      } catch (e) {
        snack('error'.tr, e.toString());
        count.value = 0;
      }
    }
  }

  //login with email and password
  Future<void> login(context) async {
    FocusScope.of(context).unfocus();
    count.value = 1;
    try {
      await _auth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((user) async => {
                FirestoreService()
                    .getCurrentUser(user.user!.uid)
                    .then((value) async {
                  saveDataLocal(
                      UserModel.fromMap(value.data() as Map<dynamic, dynamic>));
                  // getDocs(user.user!.uid);
                  Get.offAll(() => const ControllerPage());
                  count.value = 0;
                }).catchError((e){
                  snack('error'.tr, getMessageFromErrorCode(e));
                  count.value = 0; 
                })
              });
    } on FirebaseAuthException catch (e) {
      snack('error'.tr, getMessageFromErrorCode(e));
      count.value = 0;
    } catch (e) {
      snack('error'.tr, e.toString());
      count.value = 0;
    }
  }

  // logout
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    // await dbHelper.deleteAll(DatabaseHelper.showTable);
    // await dbHelper.deleteAll(DatabaseHelper.movieTable);
    // await dbHelper.deleteAll(DatabaseHelper.table);
    // update();
    UserDataPref().deleteUser();
    Get.offAll(() => const ControllerPage());
    Get.delete<HomeController>();
  }

  //switch on and off the password field
  obscureChange() {
    _obscure.value = !_obscure.value;
  }

  // select image from device
  Future<void> openImagePicker() async {
    if (_isPicked == true) {
      _isPicked = false;
      _image = File('');
      _path = '';
      update();
    } else {
      final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['png', 'jpg', 'jpeg']);

      if (result == null) {
        snack('abort'.tr, '');
      } else {
        _path = result.files.single.path.toString();
        _image = File(_path.toString());
        _isPicked = true;

        update();
      }
    }
  }

  void setUsername(String username) {
    _name = username.trim();
  }

  void setEmail(String email) {
    _email = email.trim();
  }

  void setPassword(String password) {
    _password = password.trim();
  }

  //save user data to database and locally
  saveDataFirebase(
      {UserCredential? user,
      bool? google,
      String? onlinePicPath,
      String? token,
      String? number,
      UserModel? model,
      }) {
    UserModel userModel = model ??
        UserModel(
            birthday: {},
            bio: '',
            email: (user?.user?.email).toString(),
            gender: '',
            isDarkTheme: true,
            isError: false,
            isPicLocal: _path != '',
            isSocial: google as bool,
            language: Get.deviceLocale.toString(),
            localPicPath: _path,
            messagingToken: token.toString(),
            onlinePicPath: onlinePicPath.toString(),
            phoneNumber: number.toString(),
            userId: user?.user!.uid as String,
            userName: _name,
            headAuth: '',
            headOther: '',
            );
    FirestoreService().addUsers(userModel);
    saveDataLocal(userModel);
  }

  // save user data locally
  saveDataLocal(UserModel user) {
    UserDataPref().setUser(user);
    _isPicked = false;
    _image = File('');
    _path = '';
  }
}
