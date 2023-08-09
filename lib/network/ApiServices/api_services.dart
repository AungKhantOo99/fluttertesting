import 'dart:convert';

import 'package:secondtest/network/model/AllEposodes.dart';
import 'package:secondtest/network/model/CastModel.dart';
import 'package:secondtest/network/model/categorylist.dart';
import 'package:secondtest/ulti/const.dart';
import 'package:http/http.dart' as http;
import '../model/ActorDetail.dart';
import '../model/HisFamousMovies.dart';
import '../model/HisFamousSeries.dart';
import '../model/MoviesDetails.dart';
import '../model/MoviesModel.dart';
import '../model/SeriesDetails.dart';
import '../model/SeriesModel.dart';

class ApiService {
  Map<String, String> headers = {
    'Authorization': 'Bearer $key',
    'Content-Type': 'application/json',
  };

  int currentPage = 1;

  Future<Season> fetchEpisodes(int seriesId, int seasonId) async {
    try {
      final response = await http.get(
          Uri.parse(
              "$mainUrl/tv/$seriesId?append_to_response=season/$seasonId"),
          headers: headers);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final res = data['season/$seasonId'];
        return Season.fromJson(res);
        // notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception("Fail");
    }
  }

  Future<ActorDetail> fetchActorDetails(int id) async {
    final response =
    await http.get(Uri.parse("$actorDetail$id"), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ActorDetail.fromJson(data);
      // notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<HisMovies>> fetchHisFamousMovies(int id) async {
    final response = await http.get(Uri.parse("$actorDetail$id/movie_credits"),
        headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final res = data['cast'] as List<dynamic>;

      final movies = res.map((e) => HisMovies.fromJson(e)).toList();

      return movies;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<HisSeries>> fetchHisFamousSeries(int id) async {
    final response = await http.get(Uri.parse("$actorDetail$id/tv_credits"),
        headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final res = data['cast'] as List<dynamic>;

      return res.map((e) => HisSeries.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Cast>> fetchAllCastForMovies(int id) async {
    final response = await http.get(Uri.parse("$mainUrl/movie/$id/credits"),
        headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final res = data['cast'] as List<dynamic>;

      return res.map((e) => Cast.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Cast>> fetchAllCastForSeries(int id) async {
    final response = await http.get(Uri.parse("$mainUrl/tv/$id/credits"),
        headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final res = data['cast'] as List<dynamic>;

      return res.map((e) => Cast.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Results>> fetchSearchMovies(String keyword, bool isFirst) async {
    if (isFirst) {
      currentPage = 1;
    }
    final response = await http.get(
        Uri.parse("$searchUrl?page=$currentPage&query=$keyword"),
        headers: headers);
    if (response.statusCode == 200) {
      currentPage++;
      final Map<String, dynamic> data = json.decode(response.body);

      final res = data['results'] as List<dynamic>;

      return res.map((e) => Results.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MoviesDetails> fetchMoviesDetails(int id) async {
    final response =
    await http.get(Uri.parse("$mainUrl/movie/$id"), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return MoviesDetails.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<SeriesDetails> fetchSeriesDetails(int id) async {
    final response = await http.get(
        Uri.parse("$mainUrl/tv/$id"), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return SeriesDetails.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Results>> fetchMoviesMainPage(String category, bool isFromMain,
      List<Results> data) async {
    String url = "";

    if (isFromMain) {
      url = "$mainUrl/movie/$category?page=1";
    } else {
      if (data.isEmpty) {
        url = "$mainUrl/movie/$category?page=1";
        currentPage = 1;
      } else {
        url = "$mainUrl/movie/$category?page=$currentPage";
      }
    }
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      currentPage++;
      final Map<String, dynamic> data = json.decode(response.body);

      final res = data['results'] as List<dynamic>;

      return res.map((e) => Results.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<SeriesResults>> fetchSeriesMainAndAllPage(String category,
      bool isFromMain, List<SeriesResults> data) async {
    String url = "";

    if (isFromMain) {
      url = "$mainUrl/tv/$category?page=1";
    } else {
      if (data.isEmpty) {
        url = "$mainUrl/tv/$category?page=1";
        currentPage = 1;
      } else {
        url = "$mainUrl/tv/$category?page=$currentPage";
      }
    }
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      currentPage++;
      final Map<String, dynamic> data = json.decode(response.body);

      final res = data['results'] as List<dynamic>;

      return res.map((e) => SeriesResults.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Genres>> fetchAllCategory(bool isMovies) async {
    // _allCategories.clear();
    String url = '';
    if (isMovies) {
      url = allMoviesList;
    } else {
      url = allSeriesList;
    }
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final res = data['genres'] as List<dynamic>;

        return res.map((e) => Genres.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
  }

  Future<List<Results>> fetchMoviesDependOnCategory(int index) async {
    final response = await http.get(
        Uri.parse(
            "$moviesDependOnCategory?with_genres=$index&page=$currentPage"),
        headers: headers);

    if (response.statusCode == 200) {
      currentPage++;
      final Map<String, dynamic> data = json.decode(response.body);

      final res = data['results'] as List<dynamic>;

      return res.map((e) => Results.fromJson(e)).toList();

    } else {
      throw Exception('Failed to load data');
    }
  }


  Future<List<SeriesResults>> fetchSeriesDependOnCategory(int index) async {
    final response = await http.get(
        Uri.parse(
            "$seriesDependOnCategory?with_genres=$index&page=$currentPage"),
        headers: headers);

    if (response.statusCode == 200) {
      currentPage++;
      final Map<String, dynamic> data = json.decode(response.body);

      final res = data['results'] as List<dynamic>;

      return res.map((e) => SeriesResults.fromJson(e)).toList();
      
    } else {
      throw Exception('Failed to load data');
    }
  }
}
