

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:secondtest/model/BookModel.dart';

class GetAllBookProvider extends ChangeNotifier{
  List<BookModel> _books = [];

  List<BookModel> get books => _books;

  Future<void> fetchData() async {
    final url = Uri.parse('https://picsum.photos/v2/list');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      _books = responseData.map((postJson) => BookModel.fromJson(postJson)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }
}