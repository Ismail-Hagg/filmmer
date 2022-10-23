import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

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
    if (lst.isNotEmpty) {
      for (var i = 0; i < lst.length; i++) {
        if ((lst[i].data() as Map<String, dynamic>)['postId'] == postId) {
          _mainComment =
              CommentModel.fromMap(lst[i].data() as Map<String, dynamic>);
          if ((lst[i].data() as Map<String, dynamic>)['subComments']
              .isNotEmpty) {
                _commentsList=[];
                List<dynamic> list = (lst[i].data() as Map<String, dynamic>)['subComments'];
                for (var x = 0; x < list.length; x++) {
                  _commentsList.add(
                CommentModel.fromMap(list.reversed.toList()[x]));
                }
            
          }
        }
      }
    }
  }

  // upload reply
  void uploadReply(String comment,String movieId,String firePostId,List<dynamic> subs)async{
    myFocusNode.unfocus();
    if(comment!=''){
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

      await FirestoreService().updateCommentData(movieId,firePostId,'subComments',subs).then((value) => {
        _loader=0,
        update(),
        _txtControlller.clear(),
        print(_loader)
      });    
      
    }else{
      _txtControlller.clear();
    }
  }
}
