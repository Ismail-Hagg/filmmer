// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommentModel {
  String postId;
  String pic;
  String userName;
  String userId;
  DateTime timeStamp;
  String comment;
  int likeCount;
  int dislikeCount;
  bool isSpoilers;
  bool isSub;
  List<CommentModel> subComments;
  bool isPicOnline;
  CommentModel({
    required this.postId,
    required this.pic,
    required this.userName,
    required this.userId,
    required this.timeStamp,
    required this.comment,
    required this.likeCount,
    required this.dislikeCount,
    required this.isSpoilers,
    required this.isSub,
    required this.subComments,
    required this.isPicOnline
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'pic': pic,
      'userName': userName,
      'userId': userId,
      'timeStamp': timeStamp,
      'comment': comment,
      'likeCount': likeCount,
      'dislikeCount': dislikeCount,
      'isSpoilers': isSpoilers,
      'isSub': isSub,
      'subComments': subComments,
      'isPicOnline': isPicOnline,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      postId: map['postId'] as String,
      pic: map['pic'] as String,
      userName: map['userName'] as String,
      userId: map['userId'] as String,
      timeStamp: map['timeStamp'],
      comment: map['comment'] as String,
      likeCount: map['likeCount'] as int,
      dislikeCount: map['dislikeCount'] as int,
      isSpoilers: map['isSpoilers'] as bool,
      isSub: map['isSub'] as bool,
      subComments: map['subComments'],
      isPicOnline: map['isPicOnline'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
