import 'package:flutter/material.dart';
import 'package:muvime/constants.dart';
import 'package:muvime/screens/loading_screen.dart';
import 'package:muvime/screens/movie_detail_screen.dart';
import 'package:muvime/services/movie_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(
      {super.key, required this.movieData, required this.nowPlaying});
  final APIModel movieData;
  final APIModel nowPlaying;

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final ScrollController _controller = ScrollController();
  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
  ];
  late APIModel data;
  late APIModel nowPlaying;

  @override
  Widget build(BuildContext context) {
    String text = "";
    data = widget.movieData;
    nowPlaying = widget.nowPlaying;

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, //remove backward arrow
          backgroundColor: Colors.white,
          title: const Text(
            //!!!!
            'MOVIES',
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1.0),
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.normal,
              fontSize: 24, //fontFamily
            ),
          ),
          actions: [
            DropdownButton(
              alignment: Alignment.center,
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 26.0,
              ),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!; //burasıdegiscek
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: DropdownButton(
                alignment: Alignment.center,
                icon: const Icon(
                  Icons.person_outline_outlined,
                  color: Colors.black,
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!; //burasıdegiscek
                  });
                },
              ),
            ),
          ]),
      body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _controller,
          scrollDirection: Axis.vertical,
          children: [
            Container(
              //searchbar_firstmovie
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        APIConstants.imgPath + data.results[0].poster_path),
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Color.fromRGBO(3, 153, 199, 2), //??
                      BlendMode.modulate,
                    )),
              ),
              height: 366.0,
              width: 375.0,
              child: GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, top: 22),
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
                            hintText: "Search",
                            //!!
                            hintStyle: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                              color: Color.fromRGBO(85, 85, 85, 1),
                            ),
                            suffixIcon: SizedBox(
                              width: 55,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  width: 40,
                                  margin: const EdgeInsets.all(5),
                                  color: Colors.red,
                                  child: TextButton(
                                    onPressed: () {
                                      if (text.isEmpty != true) {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return SearchLoadingScreen(
                                            searchText: text,
                                          );
                                        }));
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Container(
                                        margin: const EdgeInsets.all(0),
                                        child: const Icon(
                                          Icons.search,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, top: 25.0),
                      child: Text(
                        data.results[0].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 32.0,
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, top: 20),
                      height: 150.0,
                      child: Text(
                        data.results[0].overview,
                        maxLines: 6,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 45,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MovieDetailScreen(
                      movieData: data.results[0],
                    );
                  }));
                },
              ),
            ),
            Padding(
              //popular movies
              padding: const EdgeInsets.only(left: 12.0, top: 24.0, right: 12),
              child: SizedBox(
                height: 430.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 29,
                      child: Text(
                        'What\'s Popular',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          color: Color.fromRGBO(107, 107, 107, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 386.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return MovieCell(
                            movieData: data.results[index + 1],
                          ).build(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              //free to watch
              padding: const EdgeInsets.only(left: 12.0, top: 12.0, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 29,
                    child: Text(
                      'Free To Watch',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                        color: Color.fromRGBO(107, 107, 107, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 386.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return MovieCell(
                                movieData: nowPlaying.results[index + 5])
                            .build(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              //footer
              height: 213,
              color: const Color.fromRGBO(3, 37, 65, 1),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 36, top: 36),
                    child: Column(
                      children: const [
                        Text(
                          "THE BASIC",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24.0),
                          child: Text(
                            //bunlar link olacak
                            "About TMBD\n"
                            "Contact Us\n"
                            "Support Forums\n"
                            "API\n"
                            "System Status",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 36, top: 36),
                    child: Column(
                      children: const [
                        Text(
                          "GET INVOLVED",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24.0),
                          child: Text(
                            //bunlar link olacak
                            "Contribution Bible\n"
                            "3rd Party\n"
                            "Applications\n"
                            "Add New Movie\n"
                            "Add New TV Show",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 36, top: 36),
                    child: Column(
                      children: const [
                        Text(
                          "COMMUNITY",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24.0),
                          child: Text(
                            //bunlar link olacak
                            "Guidelines\n"
                            "Discussions\n"
                            "Leaderboard\n"
                            "Twitter",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              //subfooter
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'MOVIES',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                    child: Row(
                      children: const [
                        Icon(Icons.facebook),
                        Icon(Icons.whatsapp),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Terms of Use",
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "API Terms of Use",
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}

class MovieCell extends StatefulWidget {
  const MovieCell({super.key, required this.movieData});
  final MovieModel movieData;

  //MovieCell({this.movieCell});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 15),
      child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MovieDetailScreen(
                movieData: movieData,
              );
            }));
          },
          child: SizedBox(
              width: 187.0,
              height: 386.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 293.0,
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
                    height: 5.0,
                  ),
                  Text(
                    movieData.title,
                    maxLines: 1, //!!! isimler kırpılıyo
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    movieData.genre_ids.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieData.release_date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
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
