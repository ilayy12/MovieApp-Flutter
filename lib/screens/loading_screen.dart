import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:muvime/screens/main_screen.dart';
import 'package:muvime/screens/search_screen.dart';
import 'package:muvime/services/movie_model.dart';
import 'package:muvime/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key}); //??!!?

  @override
  State<StatefulWidget> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  late APIModel movieDatas;
  late APIModel nowPlaying;

  void getMovieData() async {
    movieDatas = await NetworkHelper().getPopularMoviesData();
    nowPlaying = await NetworkHelper().getNowPlayingMoviesData();
    Timer(
        const Duration(seconds: 3),
            () {
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MainScreen(
                    movieData: movieDatas,
                    nowPlaying: nowPlaying,
                  );
                }));
              });
            },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          Center(
            child: Text(
              'MUVIME',
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1.0),
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.normal,
                fontSize: 24, //fontFamily
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class SearchLoadingScreen extends StatefulWidget {
  const SearchLoadingScreen({super.key, required this.searchText}); //??!!?
  final String searchText;

  @override
  State<StatefulWidget> createState() => _SearchLoadingScreenState();
}

class _SearchLoadingScreenState extends State<SearchLoadingScreen> {

  @override
  void initState() {
    super.initState();
    getSearch();
  }
  late APIModel searchDatas;

  void getSearch() async {
    searchDatas = await NetworkHelper().getSearchResults(widget.searchText);
    if (searchDatas.results.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SearchScreen(
          searchText: widget.searchText,
          searchDatas : searchDatas,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'MUVIME',
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1.0),
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 24, //fontFamily
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontSize: 17,
                )
            ),
          ),
          Center(
            child: SpinKitDualRing(
              color: Colors.blueGrey.shade900,
              size: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}

/*Center(
   child: SpinKitDualRing(
   color: Colors.blueGrey.shade900,
   size: 150.0,
     ),
  ),*/