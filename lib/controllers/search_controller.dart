import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/fire_upload.dart';
import '../models/results_model.dart';
import 'favourites_controller.dart';
import 'home_controller.dart';

class SearchController extends GetxController {

  List<FirebaseSend> _display = [];
  List<FirebaseSend> get display => _display;

  final TextEditingController _txtControlller = TextEditingController();
  TextEditingController get txtControlller => _txtControlller;

  FocusNode myFocusNode = FocusNode();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // search 
  void searching(String query,List<FirebaseSend> lst) {
    final suggestion = lst.where((element) {
      final name = element.name.toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();
    _display = suggestion;
    update();
  }

  // 
  void clearThings() {
    _txtControlller.clear();
    myFocusNode.requestFocus();
    _display = [];
    update();
  }

  // navigato to detale page
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
}
