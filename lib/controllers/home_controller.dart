import 'dart:io';
import 'package:filmpro/local_storage/user_data_pref.dart';
import 'package:filmpro/models/move_model.dart';
import 'package:get/get.dart';
import '../helper/constants.dart';
import '../helper/utils.dart';
import '../models/cast_model.dart';
import '../models/home_page_model.dart';
import '../models/movie_deltale_model.dart';
import '../models/recomendation_model.dart';
import '../models/results_model.dart';
import '../models/user_model.dart';
import '../pages/movie_detale_page.dart';
import '../pages/search_more_page.dart';
import '../services/firebase_storage_service.dart';
import '../services/firestore_service.dart';
import '../services/home_page_service.dart';
import 'movie_detale_controller.dart';

class HomeController extends GetxController {
  Move _move = Move();
  Move get move => _move;
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

  HomePageModel _upcomingMovies = HomePageModel(results: [],isError: false);
  HomePageModel _popularMovies = HomePageModel(results: [],isError: false);
  HomePageModel _popularShows = HomePageModel(results: [],isError: false);
  HomePageModel _topMovies = HomePageModel(results: [],isError: false);
  HomePageModel _topShows = HomePageModel(results: [],isError: false);
  MovieDetaleModel _movieDetales = MovieDetaleModel();

  HomePageModel get upcomingMovies => _upcomingMovies;
  HomePageModel get popularMovies => _popularMovies;
  HomePageModel get popularShows => _popularShows;
  HomePageModel get topMovies => _topMovies;
  HomePageModel get topShows => _topShows;
  MovieDetaleModel get movieDetales => _movieDetales;

  List<String> urls = [upcoming, pop, popularTv, top, topTv];

  var count = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    load();
  }

  // get the user data from local storage
  void load() {
    UserDataPref().getUser.then((value) => {
          _model = value,
          apiCall(value.language),
          uploadImage(),
        });
  }

  // api calls
  void apiCall(String lan) async {
    count.value = 1;
    for (var i = 0; i < urls.length; i++) {
      await HomePageService().getHomeInfo(urls[i], lan).then((value) => {
        
            if (i == 0)
              {
                _upcomingMovies = value,
              }
            else if (i == 1)
              {
                _popularMovies = value,
              }
            else if (i == 2)
              {
                _popularShows = value,
              }
            else if (i == 3)
              {
                _topMovies = value,
              }
            else if (i == 4)
              {_topShows = value, count.value = 0}
          });
    }
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

  // navigate to search or more page
  void goToSearch(bool isSearch, String link, String title) {
    _move = Move(isSearch: isSearch, link: link, title: title);
    Get.to(() => SearchMorePage());
  }

  // navigate to the detale page
  void navToDetale(Results? res) {
    if (res!.mediaType == 'person') {
      // navigate to cast member page
      navToCast();
    } else {
      _movieDetales = MovieDetaleModel(
        recomendation: RecomendationModel(
          isError: false,
          results: [
            Results(
              voteAverage: 0.0,
              id: 0,
              posterPath: 'assets/images/oscar.jpg'
            ),
             Results(
              voteAverage: 0.0,
              id: 0,
              posterPath: 'assets/images/oscar.jpg'
            ),
             Results(
              voteAverage: 0.0,
              id: 0,
              posterPath: 'assets/images/oscar.jpg'
            ),
             Results(
              voteAverage: 0.0,
              id: 0,
              posterPath: 'assets/images/oscar.jpg'
            )
          ]
        ),
        cast: CastModel(isError: false, cast: [
          Cast(
            profilePath: 'assets/images/oscar.jpg',
            name: 'Actor',
            character: 'character',
            id:0,
            creditId: '',
          ),
          Cast(
            profilePath: 'assets/images/oscar.jpg',
            name: 'Actor',
            character: 'character',
            id:0,
            creditId: '',
          ),
          Cast(
            profilePath: 'assets/images/oscar.jpg',
            name: 'Actor',
            character: 'character',
            id:0,
            creditId: '',
          ),
          Cast(
            profilePath: 'assets/images/oscar.jpg',
            name: 'Actor',
            character: 'character',
            id:0,
            creditId: '',
          )
        ]),
        id: res.id,
        posterPath: res.posterPath,
        overview: res.overview,
        voteAverage: double.parse(res.voteAverage.toString()),
        title: res.title,
        isShow: res.isShow,
        runtime: 0,
        productionCountries: null,
        genres: null,
        releaseDate: res.releaseDate,
      );
      Get.create(() => (MovieDetaleController()), permanent: false);
      Get.to(() => MovieDetalePage(), preventDuplicates: false);
    }
  }

  // navigate to cast member page
  void navToCast(){
    print('Navigate to cast member page');
  }


}
