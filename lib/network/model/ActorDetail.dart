
class ActorDetail {
  String? biography;
  String? birthday;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  String? profilePath;

  ActorDetail(
      {this.biography,
        this.birthday,
        this.knownForDepartment,
        this.name,
        this.placeOfBirth,
        this.profilePath});

  ActorDetail.fromJson(Map<String, dynamic> json) {
    biography = json['biography'];
    birthday = json['birthday'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    placeOfBirth = json['place_of_birth'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['biography'] = biography;
    data['birthday'] = birthday;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['place_of_birth'] = placeOfBirth;
    data['profile_path'] = profilePath;
    return data;
  }
}
