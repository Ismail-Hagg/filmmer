import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constants.dart';
import '../helper/utils.dart';
import '../models/home_page_model.dart';
import '../models/move_model.dart';
import '../services/home_page_service.dart';
import 'home_controller.dart';

class SearchMorePageController extends GetxController {
  final Move _move = Get.find<HomeController>().move;
  Move get move => _move;
  FocusNode myFocusNode = FocusNode();
  TextEditingController txt = TextEditingController();

  HomePageModel _model = HomePageModel();
  HomePageModel get model => _model;

  int _page = 1;
  int get page => _page;

  int _pageLoad = 0;
  int get pageLoad => _pageLoad;

  int _indicator = 0;
  int get indicator => _indicator;

  String _query = '';
  String get query => _query;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    firstLoad();
  }

  void searchReady(String query) {
    _query = '&query=${query.trim()}';
    getMovies(_page,_query);
  }

  void firstLoad() {
    if (move.isSearch == false) {
      getMovies(_page,'');
    } else {
      _move.link = search;
    }
  }

  //load data from api
  void getMovies(int page,String query) async {
    _indicator = 1;
    await HomePageService()
        .getHomeInfo(
            '${move.link}${Get.find<HomeController>().model.language}$query&page=',
            '$page')
        .then((value) => {
              _model = value,
            });
    _indicator = 0;
    update();
  }

  // load the next result page from api
  void pageUp() async {
    if (_page == _model.totalPages) {
      snack('error'.tr, 'moreres'.tr);
    } else {
      _page++;
      _pageLoad = 1;
      await HomePageService()
          .getHomeInfo(
              '${move.link}${Get.find<HomeController>().model.language}$query&page=',
              '$page')
          .then((value) => {
                if (value.isError == true)
                  {snack('error'.tr, 'wrong'.tr)}
                else
                  {
                    for (var i = 0; i < value.results!.length; i++)
                      {_model.results!.add(value.results![i])},
                    _pageLoad = 0,
                    update()
                  },
              });
    }
  }

  // clear search field to make another search request
  void clearFocus() {
    txt.clear();
    myFocusNode.requestFocus();
  }
}
