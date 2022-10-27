import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmpro/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_page/search_page.dart';
import 'dart:math';
import '../helper/constants.dart';
import '../helper/utils.dart';
import '../local_storage/local_database.dart';
import '../models/fire_upload.dart';
import '../models/results_model.dart';
import '../models/user_model.dart';
import 'home_controller.dart';

class FavouritesController extends GetxController {
  final UserModel _user = Get.find<HomeController>().model;
  UserModel get user => _user;

  final List<FirebaseSend> _newList = [];
  List<FirebaseSend> get newList => _newList;

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  DatabaseHelper get dbHelper => _dbHelper;

  final Rx<List<FirebaseSend>> _favList = Rx([]);
  List<FirebaseSend> get favList => _favList.value;

  @override
  void onInit() {
    super.onInit();
    loadDetales();
  }

  //get userdata and favourites from local storage
  void loadDetales() async {
    await dbHelper.queryAllRows(DatabaseHelper.table).then((value) {
      for (var i = 0; i < value.length; i++) {
        _newList.add(FirebaseSend.fromMap(value[i]));
      }
      _newList.sort((a, b) => b.time.compareTo(a.time));
      update();
    });
  }

  //go to deteale page of a random movie or a show in the favourites list
  void randomnav() {
    if (_newList.isEmpty) {
      snack('No Entries', '');
    } else {
      Random random = Random();
      int randomNumber = random.nextInt(_newList.length);
      navv(_newList[randomNumber]);
    }
  }

  //delete from firestore
  void delete(FirebaseSend fire) async {
    FirestoreService().upload(_user.userId, fire, 1);
  }

  //navigato to detale page
  void navv(FirebaseSend model) {
    Get.find<HomeController>().navToDetale(Results(
      id: int.parse(model.id),
      posterPath: model.posterPath,
      overview: model.overView,
      voteAverage: model.voteAverage,
      title: model.name,
      isShow: model.isShow,
      releaseDate: model.releaseDate,
    ));
  }

  //delete from local storage and firebase
  void localDelete(String id, int index, FirebaseSend send) async {
    Get.dialog(
      AlertDialog(
        title: Text('delete'.tr),
        content: Text('sure'.tr),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: orangeColor,
            ),
            child: Text("answer".tr),
            onPressed: () async => {
              Get.back(),
              _newList.removeAt(index),
              await dbHelper.delete(DatabaseHelper.table, id),
              update(),
              delete(send)
            },
          ),
        ],
      ),
    );
  }
  
  fromDetale(FirebaseSend send, bool addOrDelete) {
    var str = [];
    if (addOrDelete == true) {
      _newList.insert(0,send);
    } else {
      for (var element in _newList) {
        str.add(element.id);
      }
      _newList.removeAt(str.indexOf(send.id));
    }
    update();
  }
}
