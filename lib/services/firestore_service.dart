import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/fire_upload.dart';
import '../models/user_model.dart';


class FirestoreService {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('Users');

  // add user data to firebase
  Future<void> addUsers(UserModel model) async {
    return await _ref.doc(model.userId).set(model.toMap());
  }

  // get the current user's data
  Future<DocumentSnapshot> getCurrentUser(String uid) async {
    return await _ref.doc(uid).get();
  }
  
  // update data fields in firebase 
  Future<void> updateData(String uid,String key,String value) async {
    return await _ref.doc(uid).update({key:value});
  }

  Future<void> upload(String userId, FirebaseSend fire, int count) async {
    if (count == 1) {
      return await _ref
          .doc(userId)
          .collection('Favourites')
          .doc(fire.id)
          .delete();
    } else if (count == 0) {
      return await _ref
          .doc(userId)
          .collection('Favourites')
          .doc(fire.id)
          .set(fire.toMap());
    }
  }
}