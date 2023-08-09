
import 'package:flutter/foundation.dart';
import 'package:secondtest/network/APiServices/api_services.dart';
import '../network/model/ActorDetail.dart';
import '../network/model/AllEposodes.dart';
import '../network/model/CastModel.dart';
import '../network/model/HisFamousMovies.dart';
import '../network/model/HisFamousSeries.dart';
import '../network/model/MoviesDetails.dart';
import '../network/model/MoviesModel.dart';
import '../network/model/SeriesDetails.dart';
import '../network/model/SeriesModel.dart';
import '../network/model/categorylist.dart';
import '../ulti/const.dart';

class GetAllMoviesDataProvider extends ChangeNotifier {
  final ApiService _apiService;
  GetAllMoviesDataProvider(this._apiService);

  Map<String, String> headers = {
    'Authorization': 'Bearer $key',
    'Content-Type': 'application/json',
  };

  int currentPage = 1;

  Map<int, List<Results>> results = {};

  Map<int, List<SeriesResults>> seriesResults = {};

  MoviesDetails _moviesDetails = MoviesDetails();
  MoviesDetails get moviesDetails => _moviesDetails;

  SeriesDetails _seriesDetails = SeriesDetails();
  SeriesDetails get seriesDetails => _seriesDetails;

  ActorDetail _actorDetails = ActorDetail();
  ActorDetail get actorDetails => _actorDetails;

  Season _seasonDetails = Season();
  Season get seasonDetails => _seasonDetails;

  List<HisMovies> _hisFamousMovies = [];
  List<HisMovies> get hisFamousMovies => _hisFamousMovies;

  List<HisSeries> _hisFamousSeries = [];
  List<HisSeries> get hisFamousSeries => _hisFamousSeries;

  List<Results> _moviesData = [];
  List<Results> get moviesData => _moviesData;

  List<Results> _popularMoviesData = [];
  List<Results> get popularMoviesData => _popularMoviesData;

  List<Results> _topRateMoviesData = [];
  List<Results> get topRateMoviesData => _topRateMoviesData;

  List<SeriesResults> _seriesData = [];
  List<SeriesResults> get seriesData => _seriesData;

  List<SeriesResults> _popularSeriesData = [];
  List<SeriesResults> get popularSeriesData => _popularSeriesData;

  List<SeriesResults> _topRateSeriesData = [];
  List<SeriesResults> get topRateSeriesData => _topRateSeriesData;

  List<Genres> _allMoviesCategories = [];
  List<Genres> get allMoviesCategories => _allMoviesCategories;

  List<Genres> _allSeriesCategories = [];
  List<Genres> get allSeriesCategories => _allSeriesCategories;

  List<Cast> _allCast = [];
  List<Cast> get allCast => _allCast;

  void fetchAllEpisodes(int seriesId, int seasonId) {
    _apiService.fetchEpisodes(seriesId, seasonId).then((value) {
      _seasonDetails = value;
      notifyListeners();
    });
  }

  void fetchActorDetails(int id) {
    _apiService.fetchActorDetails(id).then((value) {
      _actorDetails = value;
      notifyListeners();
    });
  }

  void fetchHisFamousMovies(int id) {
    _apiService.fetchHisFamousMovies(id).then((value) {
      _hisFamousMovies = value;
      notifyListeners();
    });
  }

  void fetchHisFamousSeries(int id) {
    _apiService.fetchHisFamousSeries(id).then((value) {
      _hisFamousSeries = value;
      notifyListeners();
    });
  }

  void fetchAllCastForMovies(int id) {
    _apiService.fetchAllCastForMovies(id).then((value) {
      _allCast = value;
      notifyListeners();
    });
  }

  void fetchAllCastForSeries(int id) {
    _apiService.fetchAllCastForSeries(id).then((value) {
      _allCast = value;
      notifyListeners();
    });
  }

  void fetchSearchMovies(String keyword, bool isFirst) {
    _apiService.fetchSearchMovies(keyword,isFirst).then((value) {
      if (isFirst) {_moviesData = value;}
      else {_moviesData.addAll(value);}
      notifyListeners();
    });
  }

  void fetchMoviesDetails(int id) {
    _apiService.fetchMoviesDetails(id).then((value) {
      _moviesDetails = value;
      notifyListeners();
    });
  }

  void fetchSeriesDetails(int id) {
    _apiService.fetchSeriesDetails(id).then((value) {
      _seriesDetails = value;
      notifyListeners();
    });
  }

  void fetchMoviesMainPage(String category, bool isFromMain) {
    _apiService.fetchMoviesMainPage(category,isFromMain,_moviesData).then((value) {
      if (isFromMain) {
        if (category == "popular") {
          _popularMoviesData = value;
        } else if (category == "top_rated") {
          _topRateMoviesData = value;
        }
      } else {
        _moviesData.addAll(value);
      }
      notifyListeners();
    });
  }

  void fetchSeriesMainPage(String category, bool isFromMain) {
    _apiService.fetchSeriesMainAndAllPage(category,isFromMain,_seriesData).then((value) {
      if (isFromMain) {
        if (category == "popular") {
          _popularSeriesData = value;
        } else if (category == "top_rated") {
          _topRateSeriesData = value;
        }
      } else {
        _seriesData.addAll(value);
      }
      notifyListeners();
    });
  }

  void fetchAllCategory(bool isMovies) {
    _apiService.fetchAllCategory(isMovies).then((value) {
      if (isMovies) {
        _allMoviesCategories = value;
      } else {
        _allSeriesCategories = value;
      }
      notifyListeners();
    });
  }

  void fetchMoviesDependOnCategory(int index) {
    _apiService.fetchMoviesDependOnCategory(index).then((value) {
      results[index] = (results[index] ?? [])..addAll(value);
      _moviesData = results[index]!;
      notifyListeners();
    });
  }

  void fetchSeriesDependOnCategory(int index) {
    _apiService.fetchSeriesDependOnCategory(index).then((value) {
      seriesResults[index] = (seriesResults[index] ?? [])..addAll(value);
      _seriesData = seriesResults[index]!;
      notifyListeners();
    });
  }



}
