// ignore_for_file: non_constant_identifier_names

class APIDetailModel{
  int page;
  int total_results;
  int total_pages;
  List<MovieDetailModel> results;

  APIDetailModel(this.page, this.total_pages, this.total_results, this.results);

  factory APIDetailModel.fromJson(dynamic json) {
    if (json['results'] != null) {
      var resultObjsJson = json['results'] as List;
      List<MovieDetailModel> results = resultObjsJson.map((resultsJson) =>
          MovieDetailModel.fromJson(resultsJson)).toList();

      return APIDetailModel(
          json['page'] as int,
          json['total_results'] as int,
          json['total_pages'] as int,
          results
      );
    } else {
      return APIDetailModel(
          json['page'] as int,
          json['total_results'] as int,
          json['total_pagess'] as int,
          json['results'] as List<MovieDetailModel> //!!
      );
    }
  }
  @override
  String toString() {
    return '{ $page, $results, $total_results, $total_pages }';
  }
}

class MovieDetailModel {
  bool adult;
  String backdrop_path;
  int budget;
  List<Genres> genres;
  String homepage;
  int id;
  String original_language;
  String original_title;
  String overview;
  double popularity;
  String poster_path;
  List<Companies> production_companies;
  String release_date;
  int revenue;
  int runtime;
  String tagline;
  String title;
  bool video;
  num vote_average;
  int vote_count;

  MovieDetailModel(this.adult, this.backdrop_path, this.budget,
      this.genres, this.homepage, this.id, this.original_language,
      this.original_title, this.overview, this.popularity, this.poster_path,
      this.production_companies, this.release_date, this.revenue,
      this.runtime, this.tagline, this.title, this.video,
      this.vote_average, this.vote_count);

  factory MovieDetailModel.fromJson(dynamic json) {
    var genresObjsJson = json['genres'] as List;
    List<Genres> genres = genresObjsJson.map((genresJson) =>
        Genres.fromJson(genresJson)).toList();


    var companiesObjsJson = json['production_companies'] as List;
    List<Companies> companies = companiesObjsJson.map((companiesJson) =>
        Companies.fromJson(companiesJson)).toList();

    var backdropURL = json['backdrop_path'] as String;
    if (backdropURL == 'null') {
      backdropURL = "defaultURL";
    }

    return MovieDetailModel(
      json['adult'] as bool,
      backdropURL,
      json['budget'] as int,
      genres,
      json['homepage'] as String,
      json['id'] as int,
      json['original_language'] as String,
      json['original_title'] as String,
      json['overview'] as String,
      json['popularity'] as double,
      json['poster_path'] as String,
      companies,
      json['release_date'] as String,
      json['revenue'] as int,
      json['runtime'] as int,
      json['tagline'] as String,
      json['title'] as String,
      json['video'] as bool,
      json['vote_average'] as num,
      json['vote_count'] as int,
    );
  }
  @override
  String toString() {
    return '{ $adult, $backdrop_path, $budget, $genres, $homepage, $id,'
        '$original_language, $original_title, $overview, $popularity, '
        '$poster_path, $production_companies, $release_date, $revenue, '
        '$runtime, $tagline, $title, $video, $vote_average, $vote_count }';
  }
}

class Genres {
  int id;
  String name;

  Genres(this.id, this.name);

  factory Genres.fromJson(dynamic json) {
    return Genres (
      json['id'] as int,
      json['name'] as String,
    );
  }
}

class Companies {
  String name;
  int id;
  String logo_path;
  String origin_country;

  Companies(this.name, this.id, this.logo_path, this.origin_country);

  factory Companies.fromJson(dynamic json) {
    return Companies (
      json['name'] as String,
      json['id'] as int,
      json['logo_path'] as String,
      json['origin_country'] as String,
    );
  }
}