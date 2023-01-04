import 'package:flutter/material.dart';
import 'package:muvime/services/movie_model.dart';

import '../constants.dart';
import 'cast_detail_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieData});
  final MovieModel movieData;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final ScrollController _controller = ScrollController();
  late MovieModel data;

  @override
  Widget build(BuildContext context) {
    data = widget.movieData;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          data.title,
          style: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1.0),
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            //height: 29,
            fontSize: 24, //fontFamily
          ),
        ),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(), // new
        controller: _controller,
        scrollDirection: Axis.vertical,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250.0,
                //width: 160.0,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 293.0,
                        width: 177.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: NetworkImage(
                                APIConstants.imgPath + data.poster_path),
                            fit: BoxFit.fitHeight,
                            //img border radius eklenecek
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, left: 8),
                      child: Column(
                        children: [
                          const Text(
                            "Original Title:",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Text(
                            data.original_title,
                            overflow: TextOverflow.ellipsis,
                            textWidthBasis: TextWidthBasis.parent,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            "Title:",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Text(
                            data.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textWidthBasis: TextWidthBasis.parent,
                            style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, top: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "date:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  data.release_date,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 15),
            child: Row(
              children: [
                const Text(
                  "genres:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  data.genre_ids.toString(),
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                const Text(
                  "rate:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  data.vote_average.toString(),
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "overview:",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    data.overview,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const Center(
                    child: Text(
                      "...",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            // cast
            padding: const EdgeInsets.only(left: 10.0, top: 24.0, right: 6),
            child: SizedBox(
              height: 280.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 29,
                    child: Text(
                      'Cast:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                        color: Color.fromRGBO(107, 107, 107, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 230.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const CastCell().build(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            // recommendate movies
            padding: const EdgeInsets.only(left: 12.0, top: 12.0, right: 12),
            child: SizedBox(
              height: 230.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 29,
                    child: Text(
                      'You Can Also Watch',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color.fromRGBO(107, 107, 107, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return RecommendationCell(
                          movieData: data,
                        ).build(context); //burası güncellenecek API ile
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CastCell extends StatefulWidget {
  const CastCell({super.key});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 15),
      child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const CastDetailScreen(
                  //actorname
                  );
            }));
          },
          child: SizedBox(
              //width: 187.0,
              height: 180.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150.0,
                    width: 130.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: const Image(
                        image: AssetImage("images/manicon.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Actor Name',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0,
                    ),
                  ),
                  const Text(
                    'Character',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ))),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class RecommendationCell extends StatefulWidget {
  const RecommendationCell({super.key, required this.movieData});
  final MovieModel movieData;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 10),
      child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MovieDetailScreen(
                movieData: movieData,
              );
            }));
          },
          child: SizedBox(
              //width: 170.0,
              height: 180.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 170.0,
                    width: 160.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image: NetworkImage(
                            APIConstants.imgPath + movieData.poster_path),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        movieData.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 25.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        movieData.release_date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        //budegisecek
                        movieData.vote_average.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 12, //8
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
