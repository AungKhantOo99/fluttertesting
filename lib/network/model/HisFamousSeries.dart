class HisFamousSeries {
  List<HisSeries>? series;

  HisFamousSeries({this.series});

  HisFamousSeries.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      series = <HisSeries>[];
      json['cast'].forEach((v) {
        series!.add(HisSeries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (series != null) {
      data['cast'] = series!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class HisSeries {
  int? id;
  String? posterPath;
  String? title;

  HisSeries(
      {this.id,
        this.posterPath,
        this.title,});

  HisSeries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    posterPath = json['poster_path'];
    title = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['poster_path'] = posterPath;
    data['name'] = title;
    return data;
  }
}

