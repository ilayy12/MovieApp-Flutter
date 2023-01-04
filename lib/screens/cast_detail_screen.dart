import 'package:flutter/material.dart';

class CastDetailScreen extends StatefulWidget {
  const CastDetailScreen({super.key});

  @override
  State<CastDetailScreen> createState() => _CastDetailScreenState();
}

class _CastDetailScreenState extends State<CastDetailScreen> {
  final ScrollController _controller = ScrollController();
  final actorName = "";

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
          'Actor Name',
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1.0),
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            //height: 29,
            fontSize: 24, //fontFamily
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(children: const [
          Text("actorName"),
        ]),
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
