import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../ulti/const.dart';

import '../../../network/model/MoviesModel.dart';

class MoviesRepo{
  int currentPage=1;
  Map<String, String> headers = {
    'Authorization': 'Bearer $key',
    'Content-Type': 'application/json',
  };

  // Future<List<BookModel>> fetchData() async {
  //   final url = Uri.parse('https://picsum.photos/v2/list');
  //   final response = await http.get(url);
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> responseData = json.decode(response.body);
  //     return responseData.map((postJson) => BookModel.fromJson(postJson)).toList();
  //   } else {
  //     throw Exception('Failed to fetch posts');
  //   }
  // }

  Future<List<Results>> fetchMoviesMainPage(int page) async {

    final url="$mainUrl/movie/popular?page=$page";

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {

      final Map<String,dynamic> data = json.decode(response.body);

      final res = data['results'] as List<dynamic>;

      final movies = res.map((e) => Results.fromJson(e)).toList();

      currentPage++;

      return movies;

    } else {
      throw Exception('Failed to load data');
    }

  }
}
