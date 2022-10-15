import 'dart:io';
import 'package:filmpro/local_storage/user_data_pref.dart';
import 'package:get/get.dart';
import '../helper/constants.dart';
import '../helper/utils.dart';
import '../models/home_page_model.dart';
import '../models/user_model.dart';
import '../services/firebase_storage_service.dart';
import '../services/firestore_service.dart';
import '../services/home_page_service.dart';

class HomeController extends GetxController {
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

  HomePageModel _upcomingMovies = HomePageModel();
  HomePageModel _popularMovies = HomePageModel();
  HomePageModel _popularShows = HomePageModel(); 
  HomePageModel _topMovies = HomePageModel();
  HomePageModel _topShows = HomePageModel();

  HomePageModel get upcomingMovies => _upcomingMovies;
  HomePageModel get popularMovies => _popularMovies;
  HomePageModel get popularShows => _popularShows;
  HomePageModel get topMovies => _topMovies;
  HomePageModel get topShows => _topShows;



  var count = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    load();
    // head = Get.find<AuthController>().headers;
  }

  // get the user data from local storage
  void load() {
    count.value=1;
    UserDataPref().getUser.then((value) => {
          _model = value,
          apiCall(value),
          uploadImage(),
        });
  }

  void apiCall(UserModel model) {
    getUpcoming(upcoming,model.language.replaceAll('_', '-'));
    getpopularMovies(pop,model.language.replaceAll('_', '-'));
    getpopularShows(popularTv,model.language.replaceAll('_', '-'));
    getTopRatedMovies(top,model.language.replaceAll('_', '-'));
    getTopRatedShows(topTv,model.language.replaceAll('_', '-'));
  }

  void test()async{
    // await HomePageService().getHomeInfo(upcoming,model.language.replaceAll('_', '-')).then((value) => {
    //   //print(value.results![0].voteAverage.runtimeType),
    //   print(upcoming+model.language.replaceAll('_', '-')),
    //   print(value.errorMessage.toString())
    // });
    //print((9.toDouble()));
  }

  // api call to get the upcoming movies
  getUpcoming(String link, String lan) async {
    await HomePageService().getHomeInfo(link, lan).then((value) => {
          _upcomingMovies = value,
          print('_upcomingMovies isError : ${_upcomingMovies.isError}'),
          print('_upcomingMovies isError : ${_upcomingMovies.errorMessage}'),
        });
  }

  // api call to get the popular movies
  getpopularMovies(String link, String lan) async {
    await HomePageService().getHomeInfo(link, lan).then((value) => {
          _popularMovies = value,
          print('_popularMovies isError : ${_popularMovies.isError}'),
          print('_popularMovies isError : ${_popularMovies.errorMessage}'),
        });
  }

  // api call to get the popular shows
  getpopularShows(String link, String lan) async {
    await HomePageService().getHomeInfo(link, lan).then((value) => {
          _popularShows = value,
          print('_popularMovies isError : ${_popularMovies.isError}'),
          print('_popularMovies isError : ${_popularMovies.errorMessage}'),
          
        });
  }

  // api call to get the top rated movies
  getTopRatedMovies(String link, String lan) async {
    await HomePageService().getHomeInfo(link, lan).then((value) => {
          _topMovies = value,
          print('_topMovies isError : ${_topMovies.isError}'),
          print('_topMovies isError : ${_topMovies.errorMessage}'),
        });
  }

  // api call to get the top rated movies
  getTopRatedShows(String link, String lan) async {
    await HomePageService().getHomeInfo(link, lan).then((value) => {
          _topShows = value,
          print('_topShows isError : ${_topShows.isError}'),
          print('_topShows isError : ${_topShows.errorMessage}'),
           count.value=0,
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
