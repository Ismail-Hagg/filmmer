// model of the user data that is going to be saved locally and in firebase


class UserModel {
   String userName;
   String email;
   String gender;
   String onlinePicPath;
   String localPicPath;
   String userId;
   String bio;
   Map<String,dynamic> birthday;
   bool isPicLocal;
   String language;
   bool isDarkTheme;
   bool isError;
   String phoneNumber;
   bool isSocial;
   String messagingToken;
   String headAuth;
   String headOther;

  UserModel({
    required this.userName,
    required this.email,
    required this.gender,
    required this.onlinePicPath,
    required this.localPicPath,
    required this.userId,
    required this.bio,
    required this.birthday,
    required this.isPicLocal,
    required this.language,
    required this.isDarkTheme,
    required this.isError,
    required this.phoneNumber,
    required this.isSocial,
    required this.messagingToken,
    required this.headAuth,
    required this.headOther
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
      'age': birthday,
      'isPicLocal': isPicLocal,
      'language': language,
      'isDarkTheme': isDarkTheme,
      'isError': isError,
      'phoneNumber' : phoneNumber,
      'isSocial':isSocial,
      'messagingToken':messagingToken,
      'headAuth':headAuth,
      'headOther':headOther,
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
      birthday: map['age'],
      isPicLocal: map['isPicLocal'],
      language: map['language'],
      isDarkTheme: map['isDarkTheme'],
      isError: map['isError'],
      phoneNumber : map['phoneNumber'],
      isSocial:map['isSocial'],
      messagingToken : map['messagingToken'],
      headAuth : map['headAuth'],
      headOther : map['headOther'],
    );
  }
}
