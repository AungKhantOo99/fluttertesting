class AllEpisodes {
  bool? adult;
  Season? season;
  AllEpisodes(
      {this.adult,
        this.season});
  AllEpisodes.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    // season = json['season/1'] != null
    //     ? Season.fromJson(json['season/1'])
    //     : null;
    final seasonKey = json.keys.firstWhere(
          (key) => key.startsWith('season/'),
      orElse: () => '',
    );

    // If a matching season key is found, extract the season data
    if (seasonKey.isNotEmpty) {
      season = Season.fromJson(json[seasonKey]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;

    if (season != null) {
      // data['season/1'] = season!.toJson();
       data['season/${season?.seasonNumber}'] = season?.toJson();
    }
    return data;
  }
}



class Season {
  String? sId;
  String? airDate;
  List<Episodes>? episodes;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  Season(
      {this.sId,
        this.airDate,
        this.episodes,
        this.name,
        this.overview,
        this.posterPath,
        this.seasonNumber,
        this.voteAverage});

  Season.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    airDate = json['air_date'];
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(Episodes.fromJson(v));
      });
    }
    name = json['name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    seasonNumber = json['season_number'];
    voteAverage = json['vote_average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['air_date'] = airDate;
    if (episodes != null) {
      data['episodes'] = episodes!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['season_number'] = seasonNumber;
    data['vote_average'] = voteAverage;
    return data;
  }
}

class Episodes {
  String? airDate;
  int? episodeNumber;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;
  double? voteAverage;
  int? voteCount;

  Episodes(
      {this.airDate,
        this.episodeNumber,
        this.id,
        this.name,
        this.overview,
        this.productionCode,
        this.runtime,
        this.seasonNumber,
        this.showId,
        this.stillPath,
        this.voteAverage,
        this.voteCount});

  Episodes.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    productionCode = json['production_code'];
    runtime = json['runtime'];
    seasonNumber = json['season_number'];
    showId = json['show_id'];
    stillPath = json['still_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['production_code'] = productionCode;
    data['runtime'] = runtime;
    data['season_number'] = seasonNumber;
    data['show_id'] = showId;
    data['still_path'] = stillPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;

    return data;
  }
}

