class CastModel {
  List<Cast>? cast;

  CastModel({
    this.cast,
  });

  CastModel.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      cast = <Cast>[];
      json['cast'].forEach((v) {
        cast!.add(Cast.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (cast != null) {
      data['cast'] = cast!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Cast {
  int? id;
  String? name;
  String? profilePath;
  String? character;
  String? creditId;

  Cast({
    this.id,
    this.name,
    this.profilePath,
    this.character,
    this.creditId,
  });

  Cast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePath = json['profile_path'];
    character = json['character'];
    creditId = json['credit_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profile_path'] = profilePath;
    data['character'] = character;
    data['credit_id'] = creditId;
    return data;
  }
}