
class FirebaseSend {

  String posterPath;
  String overView;
  double voteAverage;
  String name;
  bool isShow;
  String releaseDate;
  String id;
  String time;
  List<dynamic> genres;
  FirebaseSend({
    required this.posterPath,
    required this.overView,
    required this.voteAverage,
    required this.name,
    required this.isShow,
    required this.releaseDate,
    required this.id,
    required this.time,
    required this.genres,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'posterPath': posterPath,
      'overView': overView,
      'voteAverage': voteAverage,
      'name': name,
      'isShow': isShow,
      'releaseDate': releaseDate,
      'id': id,
      'time':time,
      'genres': genres,
    };
  }

   Map<String, dynamic> toMapLocal() {
    return <String, dynamic>{
      'posterPath': posterPath,
      'overView': overView,
      'voteAverage': voteAverage,
      'name': name,
      'isShow': isShow==true?1:0,
      'releaseDate': releaseDate,
      'id': id,
      'time':time,
      'genres': genres.join(","),
    };
  }
   factory FirebaseSend.fromMap(Map<String, dynamic> map){
  return FirebaseSend(
      posterPath: map['posterPath'] as String,
      overView: map['overView'] as String,
      voteAverage: map['voteAverage'] as double,
      name: map['name'] as String,
      isShow: map['isShow']==1?true:false,
      releaseDate: map['releaseDate'] as String,
      id: map['id'] as String,
      time: map['time'] ,
      genres: map['genres'].split(',')
    );
 }

  factory FirebaseSend.fromMapPre(Map<String, dynamic> map){
  return FirebaseSend(
      posterPath: map['posterPath'] as String,
      overView: map['overView'] as String,
      voteAverage: map['voteAverage'] as double,
      name: map['name'] as String,
      isShow: map['isShow'],
      releaseDate: map['releaseDate'] as String,
      id: map['id'] as String,
      time: map['time'] ,
      genres: map['genres']
    );
 }
}

