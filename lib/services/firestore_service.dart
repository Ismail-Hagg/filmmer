import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/comment_model.dart';
import '../models/fire_upload.dart';
import '../models/movie_deltale_model.dart';
import '../models/user_model.dart';


class FirestoreService {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('Users');

  final CollectionReference _comRef =
      FirebaseFirestore.instance.collection('Comments');    

  // add user data to firebase
  Future<void> addUsers(UserModel model) async {
    return await _ref.doc(model.userId).set(model.toMap());
  }

   // add user data to firebase
  Future<void> addComment(CommentModel model,String movieId,String userId) async {
    return await _comRef.doc(movieId).collection('Comments').doc().set(model.toMap());
  }

  // delete a comment
   Future<void> deleteComment(String movieId,String postId) async {
    return await _comRef.doc(movieId).collection('Comments').doc(postId).delete();
    
  }

  // get the current user's data
  Future<DocumentSnapshot> getCurrentUser(String uid) async {
    return await _ref.doc(uid).get();
  }
  
  // update data fields in firebase 
  Future<void> updateData(String uid,String key,String value) async {
    return await _ref.doc(uid).update({key:value});
  }

  // delete from watchlist or favorites
  Future<void> delete(String uid, String id, String collection) async {
    return _ref.doc(uid).collection(collection).doc(id).delete();
  }

  // update data fields in firebase 
  Future<void> updateCommentData(String movieId,String postId, String key,dynamic value) async {
    return await _comRef.doc(movieId).collection('Comments').doc(postId).update({key:value});
  }

  // upload favorites to firestore
  Future<void> upload(String userId, FirebaseSend fire, int count) async {
    if (count == 1) {
       await _ref
          .doc(userId)
          .collection('Favourites')
          .doc(fire.id)
          .delete();
    } else if (count == 0) {
       await _ref
          .doc(userId)
          .collection('Favourites')
          .doc(fire.id)
          .set(fire.toMap());
    }
  }

  // upload watchList to firestore
  Future<void> watchList(
      String userId, FirebaseSend fire, String isShow,int count) async {
        if (count == 1){
          await _ref
          .doc(userId)
          .collection('${isShow}WatchList')
          .doc(fire.id)
          .delete();
        }else if (count == 0){
          await _ref
          .doc(userId)
          .collection('${isShow}WatchList')
          .doc(fire.id)
          .set(fire.toMap());
        }
  }   
}