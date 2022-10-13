import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';


class FirestoreService {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUsers(UserModel model) async {
    return await _ref.doc(model.userId).set(model.toMap());
  }

  Future<DocumentSnapshot> getCurrentUser(String uid) async {
    return await _ref.doc(uid).get();
  }
}