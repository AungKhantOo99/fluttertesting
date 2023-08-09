
class CastModel {

  List<Cast>? cast;

  CastModel({this.cast});

  CastModel.fromJson(Map<String, dynamic> json) {

    if (json['cast'] != null) {
      cast = <Cast>[];
      json['cast'].forEach((v) { cast!.add(Cast.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (cast != null) {
      data['cast'] = cast!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cast {
  int? id;
  String? originalName;
  String? profilePath;

  Cast({
    this.id,
    this.originalName,
    this.profilePath
  });

  Cast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalName = json['original_name'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['original_name'] = originalName;
    data['profile_path'] = profilePath;
    return data;
  }
}

