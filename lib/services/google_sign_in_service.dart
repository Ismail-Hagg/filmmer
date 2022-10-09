import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

import '../controllers/auth_controller.dart';


class GoogleSignInService {
  Future<void> getGender(Map<String, String> map) async {
    try {
      final r = await http.get(
          Uri.parse(
              "https://people.googleapis.com/v1/people/me/connections?personFields=phoneNumbers,metadata,birthdays,names,photos,emailAddresses,externalIds&sources=READ_SOURCE_TYPE_PROFILE&key=AIzaSyAyDxyT-TYFJiK3GE0ZLw1zi2pyyeVYIA0"),
          headers: map);
           final response = json.decode(r.body);
    // print(response["genders"][0]["formattedValue"]);
      print(response);
    } catch (e) {
      print('failed');
    }
    // final response = json.decode(r.body);
    // print(response["genders"][0]["formattedValue"]);
    // return response["genders"][0]["formattedValue"];
  }
}
