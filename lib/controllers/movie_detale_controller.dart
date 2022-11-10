import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmpro/controllers/watchlist_controller.dart';
import 'package:filmpro/helper/utils.dart';
import 'package:filmpro/local_storage/user_data_pref.dart';
import 'package:filmpro/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../helper/constants.dart';
import '../local_storage/local_database.dart';
import '../models/comment_model.dart';
import '../models/fire_upload.dart';
import '../models/images_model.dart';
import '../models/movie_deltale_model.dart';
import '../models/trailer_model.dart';
import '../pages/sub_comment_page.dart';
import '../services/cast_service.dart';
import '../services/firestore_service.dart';
import '../services/images_service.dart';
import '../services/movie_detale_service.dart';
import '../services/recommendation_service.dart';
import '../services/trailer_service.dart';
import '../widgets/network_image.dart';
import 'favourites_controller.dart';
import 'home_controller.dart';

class MovieDetaleController extends GetxController {
  var uuid = const Uuid();

  final TextEditingController _txtControlller = TextEditingController();
  TextEditingController get txtControlller => _txtControlller;

  CommentModel _commentModel = CommentModel(
      comment: '',
      dislikeCount: 0,
      isPicOnline: false,
      isSpoilers: false,
      isSub: false,
      likeCount: 0,
      pic: '',
      postId: '',
      subComments: [],
      timeStamp: DateTime.now(),
      userId: '',
      userName: '',
      token: '');

  CommentModel get commentModel => _commentModel;

  List<CommentModel> _commentsList = [];
  List<CommentModel> get commentsList => _commentsList;

  final UserModel _userModel = Get.find<HomeController>().model;
  UserModel get userModel => _userModel;

  MovieDetaleModel _model = MovieDetaleModel();
  MovieDetaleModel get model => _model;

  FocusNode myFocusNode = FocusNode();

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

  int _commentLoader = 0;
  int get commentLoader => _commentLoader;

  final RxInt _imagesCounter = 0.obs;
  int get imagesCounter => _imagesCounter.value;

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
  void heartCheck() async {
    await dbHelper
        .querySelect(
      DatabaseHelper.table,
      _model.id.toString(),
    )
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
  void favouriteUpload() async {
    if (_loader == 0) {
      if (_model.isError == true) {
        snack('error'.tr, 'connect'.tr);
      } else {
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
            time: DateTime.now(),
            genres: lst);

        if (_heart == 0) {
          // adding to favourites locally and in firestore
          _heart = 1;
          // checking if we're coming from the favorites page
          if (Get.isRegistered<FavouritesController>() == true) {
            Get.find<FavouritesController>().fromDetale(fire, true);
          }
          await dbHelper
              .insert(fire.toMapLocal(), DatabaseHelper.table)
              .then((value) async {
            snack('favadd'.tr, '');
            update();
            await FirestoreService().upload(_userModel.userId, fire, 0);
          });
        } else {
          _heart = 0;
          if (Get.isRegistered<FavouritesController>() == true) {
            Get.find<FavouritesController>().fromDetale(fire, false);
          }
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

  // model the comments in the streambuilder
  void modelComments(List<QueryDocumentSnapshot<Object?>> lst) {
    _commentsList = [];
    if (lst.isNotEmpty) {
      for (var i = 0; i < lst.length; i++) {
        _commentsList
            .add(CommentModel.fromMap(lst[i].data() as Map<String, dynamic>));
        lst[i].get('comment');
      }
    }
  }

  //add movie or show to watchlist
  void watch() async {
    if (_loader == 0) {
      if (_model.isError == true) {
        snack('error'.tr, 'connect'.tr);
      } else {
        String table = _model.isShow != true
            ? DatabaseHelper.movieTable
            : DatabaseHelper.showTable;
        await dbHelper
            .querySelect(table, _model.id.toString())
            .then((value) async {
          if (value.isEmpty) {
            List<String> lst = [];
            String show = '';
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
                time: DateTime.now(),
                genres: lst);
            fire.isShow == true ? show = 'show' : show = 'movie';

            await dbHelper.insert(fire.toMapLocal(), table).then((value) async {
              if (Get.isRegistered<WatchlistController>() == true) {
                Get.find<WatchlistController>().fromDetale(fire, fire.isShow);
              }
              snack('watchadd'.tr, '');

              await FirestoreService()
                  .watchList(_userModel.userId, fire, show, 0);
            });
          } else {
            snack('watchalready'.tr, '');
          }
        });
      }
    }
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
                    if (value.isError == false) {_model = value}
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

  void uploadComment(String movieId, String comment) async {
    myFocusNode.unfocus();

    if (comment != '') {
      _commentLoader = 1;
      update();
      _commentModel = CommentModel(
          comment: comment,
          dislikeCount: 0,
          isPicOnline: _userModel.onlinePicPath == '' ? false : true,
          isSpoilers: false,
          isSub: false,
          likeCount: 0,
          pic: _userModel.onlinePicPath,
          postId: uuid.v4(),
          subComments: <Map<String, dynamic>>[],
          timeStamp: DateTime.now(),
          userId: _userModel.userId,
          userName: _userModel.userName,
          token: _userModel.messagingToken);
      await FirestoreService()
          .addComment(commentModel, movieId, _userModel.userId)
          .then((value) => {
                _commentLoader = 0,
                txtControlller.clear(),
                commemtCount(
                  _userModel.userId,
                  'numberOfComments',
                ),
                update()
              });
    } else {
      txtControlller.clear();
    }
  }

  // delete comments from
  void deleteComment(String movieId, String postId) async {
    Get.dialog(
      AlertDialog(
        title: Text('deletecomment'.tr),
        content: Text('deletecommentsure'.tr),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: orangeColor,
            ),
            child: Text("answer".tr),
            onPressed: () async => {
              Get.back(),
              await FirestoreService().deleteComment(movieId, postId)
            },
          ),
        ],
      ),
    );
  }

  // likes and dislikes on a comment
  void likeSystem(bool isLike, String postId, String movieId, String firePostId,
      int count) async {
    if (isLike) {
      var lst = userModel.commentLikes.split(',');
      var other = userModel.commentsDislikes.split(',');
      if (lst.contains(postId)) {
        // there is already a like so remove
        lst.remove(postId);
        _userModel.commentLikes = lst.join(',');
        saveLike(_userModel, 'commentLikes', _userModel.commentLikes, movieId,
            firePostId, 'likeCount', count - 1);
      } else {
        // add a like
        // first if there's a dislike remove it
        if (other.contains(postId)) {
          other.remove(postId);
          _userModel.commentsDislikes = other.join(',');
          saveLike(_userModel, 'commentsDislikes', _userModel.commentsDislikes,
              movieId, firePostId, 'dislikeCount', count - 1);
          lst.add(postId);
          _userModel.commentLikes = lst.join(',');
          saveLike(_userModel, 'commentLikes', _userModel.commentLikes, movieId,
              firePostId, 'likeCount', count + 1);
        } else {
          // add a like
          lst.add(postId);
          _userModel.commentLikes = lst.join(',');
          saveLike(_userModel, 'commentLikes', _userModel.commentLikes, movieId,
              firePostId, 'likeCount', count + 1);

          // notify user that someone liked his comment
        }
      }
    } else {
      var lst = userModel.commentsDislikes.split(',');
      var other = userModel.commentLikes.split(',');
      if (lst.contains(postId)) {
        // there is already a dislike so remove
        lst.remove(postId);
        _userModel.commentsDislikes = lst.join(',');
        saveLike(_userModel, 'commentsDislikes', _userModel.commentsDislikes,
            movieId, firePostId, 'dislikeCount', count - 1);
      } else {
        // add a dislike
        // first if there's a like remove it
        if (other.contains(postId)) {
          other.remove(postId);
          _userModel.commentLikes = other.join(',');
          saveLike(_userModel, 'commentLikes', _userModel.commentsDislikes,
              movieId, firePostId, 'likeCount', count + 1);
          lst.add(postId);
          _userModel.commentsDislikes = lst.join(',');
          saveLike(_userModel, 'commentsDislikes', _userModel.commentLikes,
              movieId, firePostId, 'dislikeCount', count + 1);
        } else {
          lst.add(postId);
          _userModel.commentsDislikes = lst.join(',');
          saveLike(_userModel, 'commentsDislikes', _userModel.commentLikes,
              movieId, firePostId, 'dislikeCount', count + 1);
        }
      }
    }
  }

  void saveLike(UserModel model, String key, String value, String movieId,
      String firePostId, String otherKey, dynamic otherVal) async {
    UserDataPref().setUser(model);
    await FirestoreService()
        .updateData(model.userId, key, value)
        .then((value) async => {
              await FirestoreService()
                  .updateCommentData(movieId, firePostId, otherKey, otherVal)
            });
  }

  // add count of comments or replies to the user data only on firestore
  void commemtCount(String uid, String key) async {
    await FirestoreService().getCurrentUser(uid).then((value) async => {
          if ((value.data() as Map<dynamic, dynamic>)[key] == null)
            {await FirestoreService().updateData(uid, key, '1')}
          else
            {
              await FirestoreService().updateData(
                  uid,
                  key,
                  (int.parse((value.data() as Map<dynamic, dynamic>)[key]) + 1)
                      .toString())
            }
        });
  }

  // navigate to subcomment page
  void navToSubComment(MovieDetaleController controller, String movieId,
      String postId, String firePostId) {
    Get.to(() => SubComment(
          movieId: movieId,
          mainPostId: postId,
          firePostId: firePostId,
          pastController: controller,
        ));
  }

  // call api to get images
  void getImages(double height, double width,bool isActor,String id) async {
    if(_loader==0){
      ImagesModel model = ImagesModel();
    _imagesCounter.value = 1;
    Get.dialog(Obx(
      () => Center(
        child: _imagesCounter.value == 1
            ? const CircularProgressIndicator(
                color: orangeColor,
              )
            : Container(
                child: CarouselSlider.builder(
                options: CarouselOptions(
                    height: height * 0.6, enlargeCenterPage: true),
                itemCount: model.links!.length,
                itemBuilder: (context, index, realIndex) {
                  return ImageNetwork(
                    link: imagebase + model.links![index],
                    height: height * 0.95,
                    width: width * 0.8,
                    color: orangeColor,
                    fit: BoxFit.contain,
                    isMovie: true,
                    isShadow: false,
                  );
                },
              )),
      ),
    ));
    ImagesService()
        .getImages(isActor?'person': _model.isShow == true ? 'tv' : 'movie', id,
            _userModel.language.substring(0, _userModel.language.indexOf('_')))
        .then((val) {
      model = val;
      _imagesCounter.value = 0;
    });
    }
  }
}
