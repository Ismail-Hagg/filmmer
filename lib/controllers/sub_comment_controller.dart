import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../helper/constants.dart';
import '../local_storage/user_data_pref.dart';
import '../models/comment_model.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import 'home_controller.dart';

class SubCommentControllrt extends GetxController {
  List<CommentModel> _commentsList = [];
  List<CommentModel> get commentsList => _commentsList;

  var uuid = const Uuid();

  final UserModel _userModel = Get.find<HomeController>().model;
  UserModel get userModel => _userModel;

  final TextEditingController _txtControlller = TextEditingController();
  TextEditingController get txtControlller => _txtControlller;

  final FocusNode _myFocusNode = FocusNode();
  FocusNode get myFocusNode => _myFocusNode;

  int _loader = 0;
  int get loader => _loader;

  CommentModel _mainComment = CommentModel(
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
      token: '',
      userId: '',
      userName: '');
  CommentModel get mainComment => _mainComment;

  CommentModel _modelSend = CommentModel(
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
      token: '',
      userId: '',
      userName: '');
  CommentModel get modelSend => _modelSend;

  // model the comments in the streambuilder
  void modelComments(List<QueryDocumentSnapshot<Object?>> lst, String postId) {
    _commentsList = [];
    if (lst.isNotEmpty) {
      for (var i = 0; i < lst.length; i++) {
        if ((lst[i].data() as Map<String, dynamic>)['postId'] == postId) {
          _mainComment =
              CommentModel.fromMap(lst[i].data() as Map<String, dynamic>);
          if ((lst[i].data() as Map<String, dynamic>)['subComments']
              .isNotEmpty) {
            _commentsList = [];
            List<dynamic> list =
                (lst[i].data() as Map<String, dynamic>)['subComments'];
            for (var x = 0; x < list.length; x++) {
              _commentsList
                  .insert(0,CommentModel.fromMap(list[x]));
            }
          }
        }
      }
    }
  }

  // upload reply
  void uploadReply(String comment, String movieId, String firePostId,
      List<dynamic> subs) async {
    myFocusNode.unfocus();
    if (comment != '') {
      _loader = 1;

      _modelSend = CommentModel(
          comment: comment,
          dislikeCount: 0,
          isPicOnline: _userModel.onlinePicPath == '' ? false : true,
          isSpoilers: false,
          isSub: true,
          likeCount: 0,
          pic: _userModel.onlinePicPath,
          postId: uuid.v4(),
          subComments: <Map<String, dynamic>>[],
          timeStamp: DateTime.now(),
          userId: _userModel.userId,
          userName: _userModel.userName,
          token: _userModel.messagingToken);
      subs.add(_modelSend.toMap());

      await FirestoreService()
          .updateCommentData(movieId, firePostId, 'subComments', subs)
          .then((value) =>
              {_loader = 0, update(), _txtControlller.clear()});
    } else {
      _txtControlller.clear();
    }
  }

  // delete reply
  void deleteReply(CommentModel comment, String movieId, String firePostId,
      String postId, bool isSub) async {
    Get.dialog(
      AlertDialog(
        title: Text('delrep'.tr),
        content: Text('deletereply'.tr),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: orangeColor,
            ),
            child: Text("answer".tr),
            onPressed: () async => {
              Get.back(),
              if (isSub)
                {
                  for (var i = 0; i < comment.subComments.length; i++)
                    {
                      _commentsList.remove(_commentsList[i]),
                      if (comment.subComments[i]['postId'] == postId)
                        {

                          comment.subComments.remove(comment.subComments[i]),
                          await FirestoreService().updateCommentData(movieId,
                              firePostId, 'subComments', comment.subComments).then((value) => null)
                        }
                    }
                }
              else
                {
                  Get.back(),
                  await FirestoreService().deleteComment(movieId, firePostId)
                }
            },
          ),
        ],
      ),
    );
  }

  void subLikeSystem(bool isLike,String mainPostId, String movieId, String firePostId,List<CommentModel> commentList,int index) async {
    if (isLike) {
      var lst = userModel.commentLikes.split(',');
      var other = userModel.commentsDislikes.split(',');
      if (lst.contains(commentList[index].postId)) {
        // there is already a like so remove
        lst.remove(commentList[index].postId);
        commentList[index].likeCount=commentList[index].likeCount-1;
        _userModel.commentLikes = lst.join(',');
        saveLike(_userModel, 'commentLikes', _userModel.commentLikes, movieId,
            firePostId, 'subComments', commentList);
      } else {
        // add a like
        // first if there's a dislike remove it
        if (other.contains(commentList[index].postId)) {
          other.remove(commentList[index].postId);
          commentList[index].dislikeCount=commentList[index].dislikeCount-1;
          _userModel.commentsDislikes = other.join(',');
          saveLike(_userModel, 'commentsDislikes', _userModel.commentsDislikes,
              movieId, firePostId, 'subComments', commentList);


          lst.add(commentList[index].postId);
          _userModel.commentLikes = lst.join(',');
          commentList[index].likeCount=commentList[index].likeCount+1;
          saveLike(_userModel, 'commentLikes', _userModel.commentLikes, movieId,
              firePostId, 'subComments', commentList);
        } else {
          // add a like
          lst.add(commentList[index].postId);
          _userModel.commentLikes = lst.join(',');
          commentList[index].likeCount=commentList[index].likeCount+1;
          saveLike(_userModel, 'commentLikes', _userModel.commentLikes, movieId,
              firePostId, 'subComments', commentList);

          // notify user that someone liked his comment
        }
      }
    } else {
      var lst = userModel.commentsDislikes.split(',');
      var other = userModel.commentLikes.split(',');
      if (lst.contains(commentList[index].postId)) {
        // there is already a dislike so remove
        lst.remove(commentList[index].postId);
        _userModel.commentsDislikes = lst.join(',');
        commentList[index].dislikeCount=commentList[index].dislikeCount-1;
        saveLike(_userModel, 'commentsDislikes', _userModel.commentsDislikes,
            movieId, firePostId, 'subComments', commentList);
      } else {
        // add a dislike
        // first if there's a like remove it
        if (other.contains(commentList[index].postId)) {
          other.remove(commentList[index].postId);
          _userModel.commentLikes = other.join(',');
          commentList[index].likeCount=commentList[index].likeCount-1;
          saveLike(_userModel, 'commentLikes', _userModel.commentsDislikes,
              movieId, firePostId, 'subComments', commentList);

          lst.add(commentList[index].postId);
          _userModel.commentsDislikes = lst.join(',');
          commentList[index].dislikeCount=commentList[index].dislikeCount+1;
          saveLike(_userModel, 'commentsDislikes', _userModel.commentLikes,
              movieId, firePostId, 'subComments', commentList);
        } else {
          lst.add(commentList[index].postId);
          _userModel.commentsDislikes = lst.join(',');
          commentList[index].dislikeCount=commentList[index].dislikeCount+1;
          saveLike(_userModel, 'commentsDislikes', _userModel.commentLikes,
              movieId, firePostId, 'subComments', commentList);
        }
      }
    }
  }

   void saveLike(UserModel model, String key, String value, String movieId,
      String firePostId, String otherKey, List<CommentModel> otherVal) async {
        var lst=[];
    UserDataPref().setUser(model);
    await FirestoreService()
        .updateData(model.userId, key, value)
        .then((value) async => {
          for(var i = 0; i < otherVal.length; i++){
            lst.add(otherVal[i].toMap())
          },
              await FirestoreService()
                  .updateCommentData(movieId, firePostId, otherKey, lst)
            });
  }
}
