
class MoviesDetails {
  String? originalLanguage;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  double? voteAverage;
  int? voteCount;

  MoviesDetails(
      {this.originalLanguage,
        this.overview,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.voteAverage,
        this.voteCount});

  MoviesDetails.fromJson(Map<String, dynamic> json) {
    originalLanguage = json['original_language'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original_language'] = this.originalLanguage;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }
}


