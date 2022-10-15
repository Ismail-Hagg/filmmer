import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';


// api call to get google user information
class GoogleSignInService {
  Future<UserModel> googleLogIn(Map<String, String> headers, String uid,
      String token, String number) async {
        print(headers);
        print(headers.runtimeType);
    UserModel model = UserModel(
        birthday: {},
        bio: '',
        email: '',
        gender: '',
        isDarkTheme: false,
        isError: true,
        isPicLocal: false,
        isSocial: false,
        language: Get.deviceLocale.toString(),
        localPicPath: '',
        messagingToken: '',
        onlinePicPath: '',
        phoneNumber: '',
        userId: '',
        userName: '',
        headAuth: '',
        headOther: '');
    String host = 'https://people.googleapis.com';
    String endPoint =
        '/v1/people/me?personFields=birthdays,emailAddresses,genders,photos,names';

    try {
      final requests =
          await http.get(Uri.parse("$host$endPoint"), headers: headers);

      if (requests.statusCode == 200) {
        model = UserModel(
            birthday: (json.decode(requests.body)['birthdays'][0]['date']),
            bio: '',
            email: (json.decode(requests.body)['emailAddresses'][0]['value']),
            gender: (json.decode(requests.body)['genders'][0]['value']),
            isDarkTheme: true,
            isError: false,
            isPicLocal: false,
            isSocial: true,
            language: Get.deviceLocale.toString(),
            localPicPath: '',
            messagingToken: token,
            onlinePicPath: (json.decode(requests.body)['photos'][0]['url']),
            phoneNumber: number,
            userId: uid,
            userName: (json.decode(requests.body)['names'][0]['displayName']),
            headAuth: headers['Authorization'].toString(),
            headOther: headers['X-Goog-AuthUser'].toString(),);
        return model;
      } else {
        return model;
      }
    } catch (e) {
      return model;
    }
    
  }

}
