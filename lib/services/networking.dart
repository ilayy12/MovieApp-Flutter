import 'dart:convert';
import 'package:http/http.dart';
import 'package:muvime/constants.dart';
import 'package:muvime/services/movie_detail_model.dart';
import 'package:muvime/services/movie_model.dart';

import 'cast_model.dart';

//pagination / localization / darkmod >>>>ADD

class NetworkHelper {
  late String url;
  late String data;

  Future<APIModel> getPopularMoviesData() async {
    var url = Uri.parse(
        APIConstants.movieDB + APIConstants.moviePopular + APIConstants.apiKey);
    final response = await get(url);
    if (response.statusCode == 200) {
      APIModel model = APIModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      throw Exception('Failed to load Movie Informations');
    }
  }

  ///kullanılacak
  Future<APIDetailModel> getMovieDetailsData(int id) async {
    var url = Uri.parse(
        APIConstants.movieDB + APIConstants.movieDetails + id.toString() + APIConstants.apiKey);
    final response = await get(url);
    if (response.statusCode == 200) {
      APIDetailModel model = APIDetailModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      throw Exception('Failed to load Movie Informations');
    }
  }

  ///kullanılacak
  Future<APICastModel> getMovieCastData(int id) async {
    var url = Uri.parse(
        APIConstants.movieDB + APIConstants.movieDetails + id.toString()
            +APIConstants.cast + APIConstants.apiKey);
    final response = await get(url);
    if (response.statusCode == 200) {
      APICastModel model = APICastModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      throw Exception('Failed to load Cast Informations');
    }
  }

  Future<APIModel> getNowPlayingMoviesData() async {
    var url = Uri.parse(
        APIConstants.movieDB + APIConstants.nowPlaying + APIConstants.apiKey);
    final response = await get(url);
    if (response.statusCode == 200) {
      APIModel model = APIModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      throw Exception('Failed to load Movie Informations');
    }
  }

  Future<APIModel> getSearchResults(String text) async {
    var url = Uri.parse(
        "${APIConstants.movieDB}${APIConstants.searchMovie}${APIConstants.apiKey}${APIConstants.query}$text");
    final response = await get(url);
    if (response.statusCode == 200) {
      APIModel model = APIModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
