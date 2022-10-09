// model of the user data that is going to be saved locally and in firebase

class UserModel {
  final String userName;
  final String email;
  final String gender;
  final String onlinePicPath;
  final String localPicPath;
  final String userId;
  final String bio;
  final int age;
  final bool isPicLocal;
  final Map<String, String> language;
  final bool isDarkTheme;
  final bool isError;
  final String phoneNumber;

  UserModel({
    required this.userName,
    required this.email,
    required this.gender,
    required this.onlinePicPath,
    required this.localPicPath,
    required this.userId,
    required this.bio,
    required this.age,
    required this.isPicLocal,
    required this.language,
    required this.isDarkTheme,
    required this.isError,
    required this.phoneNumber
  });

  toMap() {
    return {
      'userName': userName,
      'email': email,
      'gender': gender,
      'onlinePicPath': onlinePicPath,
      'localPicPath': localPicPath,
      'userId': userId,
      'bio': bio,
      'age': age,
      'isPicLocal': isPicLocal,
      'language': language,
      'isDarkTheme': isDarkTheme,
      'isError': isError,
      'phoneNumber' : phoneNumber
    };
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      userName: map['userName'],
      email: map['email'],
      gender: map['gender'],
      onlinePicPath: map['onlinePicPath'],
      localPicPath: map['localPicPath'],
      userId: map['userId'],
      bio: map['bio'],
      age: map['age'],
      isPicLocal: map['isPicLocal'],
      language: map['language'],
      isDarkTheme: map['isDarkTheme'],
      isError: map['isError'],
      phoneNumber : map['phoneNumber'],
    );
  }
}
