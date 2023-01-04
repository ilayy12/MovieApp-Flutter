
// ignore_for_file: non_constant_identifier_names

class APICastModel {
  int id;
  List<CastDetail> cast;

  APICastModel(this.id, this.cast);

  factory APICastModel.fromJson(dynamic json) {
    if (json['cast'] != null) {
      var castObjsJson = json['cast'] as List;
      List<CastDetail> cast = castObjsJson.map((castJson) =>
          CastDetail.fromJson(castJson)).toList();

      return APICastModel(
          json['id'] as int,
          cast,
      );
    } else {
      return APICastModel(
          json['id'] as int,
          json['cast'] as List<CastDetail> //!!
      );
    }
  }
}

class CastDetail {
  int id;
  String known_for_department;
  int gender;
  String name;
  String profile_path;
  String character;
  int order;

  CastDetail(this.id, this.known_for_department, this.gender,
      this.name, this.profile_path, this.character, this.order);

  factory CastDetail.fromJson(dynamic json) {
    var profileURL = json['profile_path'] as String;
    if (profileURL == 'null') {
      profileURL = "defaultURL";
    }

    return CastDetail(
      json['id'] as int,
      json['known_for_department'] as String,
      json['gender'] as int,
      json['name'] as String,
      profileURL,
      json['character'] as String,
      json['order'] as int,
    );
  }
}