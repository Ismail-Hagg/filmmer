import 'package:get/get.dart';

import '../helper/constants.dart';
import '../models/movie_deltale_model.dart';
import '../models/trailer_model.dart';
import '../services/cast_service.dart';
import '../services/movie_detale_service.dart';
import '../services/recommendation_service.dart';
import '../services/trailer_service.dart';
import 'home_controller.dart';

class MovieDetaleController extends GetxController {
  MovieDetaleModel _model = MovieDetaleModel();
  MovieDetaleModel get model => _model;

  TrailerModel _trailer = TrailerModel();
  TrailerModel get trailer => _trailer;

  int _loader = 0;
  int get loader => _loader;

  List<String> slashes = ['', 'credits', 'recommendations', 'videos'];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _model = Get.find<HomeController>().movieDetales;
    getData(_model);
  }

  // get data from api
  void getData(MovieDetaleModel res) async {
    _loader = 1;
    update();
    var lan = (Get.find<HomeController>().model.language).replaceAll('_', '-');
    var show = res.isShow == true ? 'tv' : 'movie';
    var slash = '';
    var base = 'https://api.themoviedb.org/3/$show/${res.id}';
    var end = '?api_key=$apiKey&language=$lan';

    for (var i = 0; i < slashes.length; i++) {
      switch (i) {
        case 0:
          await MovieDetaleService()
              .getHomeInfo('$base${slashes[i]}$end')
              .then((value) => {_model = value});
          break;
        case 1:
          await CastService()
              .getHomeInfo('$base/${slashes[i]}$end')
              .then((value) => {_model.cast = value});
          break;
        case 2:
          slash = slashes[i];
          await RecommendationService()
              .getHomeInfo('$base/${slashes[i]}$end')
              .then((value) => {_model.recomendation = value});
          break;
        case 3:
          slash = slashes[i];
          await TrailerService()
              .getHomeInfo('$base/${slashes[i]}$end')
              .then((value) => {_trailer = value});
          break;
      }
    }
    _loader = 0;
    update();
  }


  String getTimeString(int value) {
  final int hour = value ~/ 60;
  final int minutes = value % 60;
  return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
}
}
