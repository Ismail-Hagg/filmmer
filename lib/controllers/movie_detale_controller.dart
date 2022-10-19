import 'package:filmpro/helper/utils.dart';
import 'package:filmpro/models/user_model.dart';
import 'package:get/get.dart';

import '../helper/constants.dart';
import '../local_storage/local_database.dart';
import '../models/fire_upload.dart';
import '../models/movie_deltale_model.dart';
import '../models/trailer_model.dart';
import '../services/cast_service.dart';
import '../services/firestore_service.dart';
import '../services/movie_detale_service.dart';
import '../services/recommendation_service.dart';
import '../services/trailer_service.dart';
import 'home_controller.dart';

class MovieDetaleController extends GetxController {
  final UserModel _userModel = Get.find<HomeController>().model;
  UserModel get userModel => _userModel;
  MovieDetaleModel _model = MovieDetaleModel();
  MovieDetaleModel get model => _model;

  MovieDetaleModel _backUp = MovieDetaleModel();
  MovieDetaleModel get backUp => _backUp;

  TrailerModel _trailer = TrailerModel();
  TrailerModel get trailer => _trailer;

  int _loader = 0;
  int get loader => _loader;

  final dbHelper = DatabaseHelper.instance;

  List<String> slashes = ['', 'credits', 'recommendations', 'videos'];

  int _heart = 0;
  int get heart => _heart;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _model = Get.find<HomeController>().movieDetales;
    _backUp = Get.find<HomeController>().movieDetales; 
    heartCheck();
    getData(_model);
  }

  // check if movie or show is in local database for favorites
  void heartCheck()async{
    await dbHelper
          .querySelect(DatabaseHelper.table, _model.id.toString(),)
          .then((value) async {
        if (value.isEmpty) {
          _heart = 0;
        } else {
          _heart = 1;
        }
        update();
      });
  }

  // adding to and removing from local database and firestore
  void favouriteUpload()async {
    if(_loader==0){
      if (_model.isError==true) {
        snack('error'.tr,'connect'.tr);
      }else{
        List<String> lst = [];

      for (var i = 0; i < _model.genres!.length; i++) {
        lst.add(_model.genres![i].name.toString());
      }

      FirebaseSend fire = FirebaseSend(
          posterPath: _model.posterPath.toString(),
          overView: _model.overview.toString(),
          voteAverage: _model.voteAverage as double,
          name: _model.title.toString(),
          isShow: _model.isShow as bool,
          releaseDate: _model.releaseDate.toString(),
          id: _model.id.toString(),
          time: DateTime.now().toString(),
          genres: lst);

        
       if (_heart==0) {
        // adding to favourites locally and in firestore
         _heart=1;
         // checking if we're coming from the favorites page
        // if (Get.isRegistered<FavoritesController>() == true) {
        //   Get.find<FavoritesController>().fromDetale(fire, true);
        // }
        await dbHelper
            .insert(fire.toMapLocal(), DatabaseHelper.table)
            .then((value) async {
              print(value.toString());
          snack('favadd'.tr, '');
          update();
          await FirestoreService().upload(_userModel.userId, fire, 0);
        });
      } else {
        _heart=0;
        //   if (Get.isRegistered<FavoritesController>() == true) {
        //   Get.find<FavoritesController>().fromDetale(fire, false);
        // }
        await dbHelper
            .delete(DatabaseHelper.table, fire.id)
            .then((value) async {
          snack('favalready'.tr, '');
          update();
          await FirestoreService().upload(_userModel.userId, fire, 1);
        });
       }   
      }
    }
  }

  void queryAll()async{
    //await dbHelper.querySelect(DatabaseHelper.table, _userModel.userId.toString()).then((value) => print(value));
    await dbHelper.queryAllRows(DatabaseHelper.table).then((value) => print(value));
  }

  // get data from api
  void getData(MovieDetaleModel res) async {
    _loader = 1;
    update();
    var lan = (userModel.language).replaceAll('_', '-');
    var show = res.isShow == true ? 'tv' : 'movie';
    var base = 'https://api.themoviedb.org/3/$show/${res.id}';
    var end = '?api_key=$apiKey&language=$lan';

    for (var i = 0; i < slashes.length; i++) {
      switch (i) {
        case 0:
          await MovieDetaleService()
              .getHomeInfo('$base${slashes[i]}$end')
              .then((value) => {
                if(value.isError==false){
                  _model = value
                }
              });
          break;
        case 1:
          await CastService()
              .getHomeInfo('$base/${slashes[i]}$end')
              .then((value) => {_model.cast = value});
          break;
        case 2:
          await RecommendationService()
              .getHomeInfo('$base/${slashes[i]}$end')
              .then((value) => {_model.recomendation = value});
          break;
        case 3:
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
