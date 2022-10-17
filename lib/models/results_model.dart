class Results {
  String? backdropPath;
  List<dynamic>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  bool? isShow;
  String? mediaType;

  Results(
      {
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      required this.voteAverage,
      this.mediaType,
      this.isShow});

  Results.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title']??json['original_name'];
    overview = json['overview'];
    popularity = json['popularity']!=null?(json['popularity'].toString()):'';
    posterPath = json['media_type']=='person'? json['profile_path']:json['poster_path'];
    releaseDate = json['release_date']??'Year';
    title = json['title'] ?? json['name'];
    video = json['video']??false;
    voteAverage = json['vote_average']!=null? double.parse(json['vote_average'].toString()):0.0;
    isShow = json['first_air_date']!=null?true:false;
    mediaType = json['media_type']??'';
  }

  Map<String, dynamic> toJson() { 
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    return data;
  }
}