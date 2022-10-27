import 'package:filmpro/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constants.dart';
import '../helper/utils.dart';
import '../local_storage/local_database.dart';
import '../models/fire_upload.dart';
import '../models/results_model.dart';
import '../models/user_model.dart';
import '../pages/search_page.dart';
import 'home_controller.dart';
import 'dart:math';

class WatchlistController extends GetxController {
  final UserModel _user = Get.find<HomeController>().model;
  UserModel get user => _user;

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  DatabaseHelper get dbHelper => _dbHelper;

  int _count = 0;
  int get count => _count;

  final List<FirebaseSend> _moviesLocal = [];
  List<FirebaseSend> get movieList => _moviesLocal;

  final List<FirebaseSend> _showLocal = [];
  List<FirebaseSend> get showList => _showLocal;

  @override
  void onInit() {
    super.onInit();
    loadDetales();
  }

  // get user data and watchlist from local storage
  void loadDetales() async {
    await dbHelper.queryAllRows(DatabaseHelper.movieTable).then((value) {
      for (var i = 0; i < value.length; i++) {
        _moviesLocal.add(FirebaseSend.fromMap(value[i]));
      }
      _moviesLocal.sort((a, b) => b.time.compareTo(a.time));
    });

    await dbHelper.queryAllRows(DatabaseHelper.showTable).then((value) {
      for (var i = 0; i < value.length; i++) {
        _showLocal.add(FirebaseSend.fromMap(value[i]));
      }
      _showLocal.sort((a, b) => b.time.compareTo(a.time));
    });
    update();
  }

  void change(int count) {
    _count = count;
    update();
  }

  void fromDetale(FirebaseSend send, bool isShow) {
    if (isShow == true) {
      showList.insert(0, send);
    } else {
      movieList.insert(0, send);
    }
    update();
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

  //delete from local storage and from firebase
  delete(int index) async {
    String id = '';
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
              if (_count == 1)
                {
                  id = _showLocal[index].id,
                  _showLocal.removeAt(index),
                  await dbHelper.delete(DatabaseHelper.showTable, id),
                  update(),
                  FirestoreService().delete(_user.userId, id, 'showWatchList'),
                }
              else
                {
                  id = _moviesLocal[index].id,
                  _moviesLocal.removeAt(index),
                  await dbHelper.delete(DatabaseHelper.movieTable, id),
                  update(),
                  FirestoreService().delete(_user.userId, id, 'movieWatchList'),
                }
            },
          ),
        ],
      ),
    );
  }

  // go to search page
  void searching(){
    if(_count == 0){
      Get.to(()=>SearchPage(list: _moviesLocal));
    }else{
      Get.to(()=>SearchPage(list: _showLocal));
    }
    
  }

  // random movie or a show
  void randomNav() {
    Random random = Random();
    if (_count == 0) {
      if (_moviesLocal.isNotEmpty) {
        int randomNumber = random.nextInt(_moviesLocal.length);
        Get.find<HomeController>().navToDetale(Results(
          id: int.parse(_moviesLocal[randomNumber].id),
          posterPath: _moviesLocal[randomNumber].posterPath,
          overview: _moviesLocal[randomNumber].overView,
          voteAverage: _moviesLocal[randomNumber].voteAverage,
          title: _moviesLocal[randomNumber].name,
          isShow: _moviesLocal[randomNumber].isShow,
          releaseDate: _moviesLocal[randomNumber].releaseDate,
        ));
      } else {
        snack('No Entries', '');
      }
    } else {
      if (_showLocal.isNotEmpty) {
        int randomNumber = random.nextInt(_showLocal.length);
        Get.find<HomeController>().navToDetale(Results(
          id: int.parse(_showLocal[randomNumber].id),
          posterPath: _showLocal[randomNumber].posterPath,
          overview: _showLocal[randomNumber].overView,
          voteAverage: _showLocal[randomNumber].voteAverage,
          title: _showLocal[randomNumber].name,
          isShow: _showLocal[randomNumber].isShow,
          releaseDate: _showLocal[randomNumber].releaseDate,
        ));
      } else {
        snack('No Entries', '');
      }
    }
  }
}
