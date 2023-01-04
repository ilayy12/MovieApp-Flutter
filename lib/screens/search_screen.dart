import 'package:flutter/material.dart';
import 'package:muvime/screens/loading_screen.dart';
import '../constants.dart';
import '../services/movie_model.dart';
import 'movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(
      {super.key, required this.searchText, required this.searchDatas});
  final String searchText;
  final APIModel searchDatas;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late APIModel searchData;

  @override
  Widget build(BuildContext context) {
    String text = "";
    searchData = widget.searchDatas;

    var padding = MediaQuery.of(context).padding;
    double dHeight = MediaQuery.of(context).size.height;
    double newheight = dHeight - padding.top - padding.bottom;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            var count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 2;
            });
          },
        ),
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'SEARCH',
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1.0),
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 24, //fontFamily
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 22),
              child: SizedBox(
                height: 48,
                child: TextField(
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: Colors.black54,
                  style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                  onChanged: (searched) {
                    text = searched;
                  },
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(255, 255, 255, 50),
                    filled: true,
                    hintText: widget.searchText,
                    //!!
                    hintStyle: const TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: Color.fromRGBO(85, 85, 85, 1),
                    ),
                    suffixIcon: SizedBox(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 0, bottom: 0, right: 0),
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          width: 40,
                          color: Colors.red,
                          child: TextButton(
                            onPressed: () {
                              if (text.isEmpty != true) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SearchLoadingScreen(
                                    searchText: text,
                                  );
                                }));
                              }
                            },
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: newheight - 48,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return SearchCell(
                        movieData: searchData.results[index],
                      ).build(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchCell extends StatefulWidget {
  const SearchCell({super.key, required this.movieData});
  final MovieModel movieData;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MovieDetailScreen(
                movieData: movieData,
              );
            }));
          },
          child: SizedBox(
              width: 375.0,
              height: 250.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 233.0,
                    width: 187.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image: NetworkImage(
                            APIConstants.imgPath + movieData.poster_path),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          movieData.title,
                          maxLines: 4,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          movieData.genre_ids.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movieData.release_date,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                child: Text(
                                  //budegisecek
                                  movieData.vote_average.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15, //8
                                    color: Colors.blueGrey.shade900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
