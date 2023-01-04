// ignore_for_file: non_constant_identifier_names

class APIModel{
  int page;
  int total_results;
  int total_pages;
  List<MovieModel> results;

  APIModel(this.page, this.total_pages, this.total_results, this.results);

  factory APIModel.fromJson(dynamic json) {
    if (json['results'] != null) {
      var resultObjsJson = json['results'] as List;
      List<MovieModel> results = resultObjsJson.map((resultsJson) =>
          MovieModel.fromJson(resultsJson)).toList();

      return APIModel(
          json['page'] as int,
          json['total_results'] as int,
          json['total_pages'] as int,
          results
      );
    } else {
      return APIModel(
          json['page'] as int,
          json['total_results'] as int,
          json['total_pagess'] as int,
          json['results'] as List<MovieModel> //!!
      );
    }
  }
  @override
  String toString() {
    return '{ $page, $results, $total_results, $total_pages }';
  }
}

class MovieModel {
  bool adult;
  String backdrop_path;
  List<int> genre_ids;
  int id;
  String original_language;
  String original_title;
  String overview;
  double popularity;
  String poster_path;
  String release_date;
  String title;
  bool video;
  num vote_average;
  int vote_count;

  MovieModel(this.adult, this.backdrop_path, this.genre_ids,
      this.id, this.original_language, this.original_title,
      this.overview, this.popularity, this.poster_path,
      this.release_date, this.title, this.video,
      this.vote_average, this.vote_count);

  factory MovieModel.fromJson(dynamic json) {
    var genreObjsJson = json['genre_ids'] as List;
    List<int> genres = genreObjsJson != null ? List.from(genreObjsJson) : null!;

    String backdropURL;
    if (json['backdrop_path'] == null) {
      backdropURL = "defaultURL";
    } else {
      backdropURL = json["backdrop_path"] as String;
    }

    String posterpathpURL;
    if (json['poster_path'] == null) {
      posterpathpURL = "defaultURL";
    } else {
      posterpathpURL = json["poster_path"] as String;
    }

    return MovieModel(
      json['adult'] as bool,
      backdropURL,
      genres,
      json['id'] as int,
      json['original_language'] as String,
      json['original_title'] as String,
      json['overview'] as String,
      json['popularity'] as double,
      posterpathpURL,
      json['release_date'] as String,
      json['title'] as String,
      json['video'] as bool,
      json['vote_average'] as num,
      json['vote_count'] as int,
    );
  }
  @override
  String toString() {
    return '{ $adult, $backdrop_path, $genre_ids, $id,'
        '$original_language, $original_title, $overview, $popularity, '
        '$poster_path, $release_date, $title, $video, '
        '$vote_average, $vote_count }';
  }
}