import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filmpro/services/google_sign_in_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../helper/constants.dart';
import '../pages/controller_page.dart';

class AuthController extends GetxController {
  final Rxn<User> _user = Rxn<User>();
  User? get user => _user.value;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn get google => _googleSignIn;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email', "https://www.googleapis.com/auth/contacts.readonly"]);

  final _count = 0.obs;
  final _obscure = true.obs;

  RxInt get count => _count;
  RxBool get obcure => _obscure;

  File _image=File('');
  File get image => _image;
  String _path = '';
  String get path => _path;
  bool _isPicked=false;
  bool get isPicked => _isPicked;



  // the onInint function runs when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    update();
  }


    void googleSignInMethod() async {
    count.value = 1;
    try {
      final dynamic googleUser = await _googleSignIn.signIn() ?? '';
      if (googleUser == '') {
        snack('abort'.tr,'');

        count.value = 0;
      } else {
        GoogleSignInAuthentication authy = await googleUser!.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: authy.idToken, accessToken: authy.accessToken);
        await _auth.signInWithCredential(credential).then((user) async => {
          _googleSignIn.currentUser?.authHeaders.then((value)async => {
            GoogleSignInService().getGender(value)
            
          }),
              // saveUser(user, true),
              // getDocs(user.user!.uid),
              Get.offAll(() => const ControllerPage())
            });
      }
    } on FirebaseAuthException catch (e) {
      snack('Firebase Error', e.toString());
      print(e.toString());

      count.value = 0;
    } catch (e) {
      snack('Error', e.toString());
      count.value = 0;
    }
  }

   



  Future<void> signOut() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.clear();
    await _auth.signOut();
    await _googleSignIn.signOut();
    // await dbHelper.deleteAll(DatabaseHelper.showTable);
    // await dbHelper.deleteAll(DatabaseHelper.movieTable);
    // await dbHelper.deleteAll(DatabaseHelper.table);
    // update();
     Get.offAll(() => const ControllerPage());
  }

   obscureChange() {
    _obscure.value = !_obscure.value;
  }

  // select image from device
  Future<void> openImagePicker() async {
    if (_isPicked==true) {
      _isPicked = false;
      _image=File('');
      _path='';
      update();
    } else {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg','jpeg']);
 
    if (result == null) {
      snack('abort'.tr,'');
    } else {
      _path = result.files.single.path.toString();
      _image = File(_path.toString());
      _isPicked=true;
      update();
      
    }
    }
  }

 


}
