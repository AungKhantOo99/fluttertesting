  class HisFamousMovies {
  List<HisMovies>? movies;

  HisFamousMovies({this.movies});

  HisFamousMovies.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      movies = <HisMovies>[];
      json['cast'].forEach((v) {
        movies!.add(HisMovies.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (movies != null) {
      data['cast'] = movies!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class HisMovies {
  int? id;
  String? posterPath;
  String? title;


  HisMovies(
      {this.id,
        this.posterPath,
        this.title,});

  HisMovies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    posterPath = json['poster_path'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['poster_path'] = posterPath;
    data['title'] = title;
    return data;
  }
}

