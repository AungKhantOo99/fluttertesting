
class Movies {
  int? page;
  List<Results>? results;
  double? totalPages;
  double? totalResults;

  Movies({this.page, this.results, this.totalPages, this.totalResults});

  Movies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Results {
  int? id;
  String? posterPath;
  String? title;
  num? voteAverage;

  Results(
      {this.id,
        this.posterPath,
        this.title,
        this.voteAverage,
      });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    posterPath = json['poster_path'];
    title = json['title'];
    voteAverage = json['vote_average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['poster_path'] = posterPath;
    data['title'] = title;
    data['vote_average'] = voteAverage;
    return data;
  }
}
