import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
}