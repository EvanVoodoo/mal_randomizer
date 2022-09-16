import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:english_words/english_words.dart';
import 'dart:convert';
import 'dart:math';
import "./anime_list_view.dart";
import './filters_view.dart';
import 'anime_view.dart';

void main() {
  runApp(MalPicker());
}

List<Color> colorPalette = <Color>[
  const Color.fromRGBO(48, 84, 164, 1.0),
  const Color.fromRGBO(148, 181, 252, 1.0),
  const Color.fromRGBO(23, 40, 79, 1.0),
];

class MalPicker extends StatelessWidget {
  const MalPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MAL Picker",
      theme: ThemeData(
        primaryColor: colorPalette[0], //const Color.fromRGBO(48, 84, 164, 1),
        indicatorColor: colorPalette[1],
      ),
      home: Homepage("MAL Picker Homepage"),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage(this.title, {super.key});

  final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

AnimeList animeList = AnimeList();
FilterView filterView = FilterView();

class _HomepageState extends State<Homepage> {
  Future<AnimeList> fetchAnimeList() async {
    Random rnd = Random();
    String q = nouns.elementAt(rnd.nextInt(2537));
    final response = await http.get(
      Uri.parse(
          'https://api.myanimelist.net/v2/anime?q=$q&fields=id,title,main_picture,genres, rating'),
      headers: <String, String>{
        'X-MAL-CLIENT-ID': "564c1c4a446e35f7ffd0e46898a7dc43"
      },
    );
    AnimeList aList = AnimeList.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200 && aList.animes.isNotEmpty) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(q);
      // Filter : Genres
      List<dynamic> genres = filterView.activeGenreFilters;
      print("These are the selected genres: $genres");
      if (genres.isNotEmpty) {
        for (var x in genres) {
          List<Anime> removalList = [];
          for (var a in aList.animes) {
            if (!a.getGenres.contains(x)) {
              removalList.add(a);
            }
          }
          for (var a in removalList) {
            aList.animes.remove(a);
          }
        }
      }
      // Filter : Ratings
      List<dynamic> ratings = filterView.activeRatingFilters;
      print("These are the selected ratings: $ratings");

      List<Anime> removalList = [];
      for (var a in aList.animes) {
        bool included = false;
        for (var x in ratings) {
          if (a.getRating == x) {
            included = true;
          }
        }
        if (!included) removalList.add(a);
      }
      for (var a in removalList) {
        aList.animes.remove(a);
      }

      setState(() {});
      return aList;
    } else if (response.statusCode == 404 || aList.animes.isEmpty) {
      print("Query  $q  gave no results, searching again. " +
          response.statusCode.toString());
      return fetchAnimeList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load anime list: ' + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorPalette[0],
          title: const Text(
            " MAL Randomizer",
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Random Anime"),
              Tab(text: "Filters"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 489.4,
                    child: Center(
                      child: AnimeListView(animeList),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorPalette[0],
                      ),
                      onPressed: () {
                        print(fetchAnimeList().then((result) {
                          print(result.animes);
                          animeList = result;
                        }));
                      },
                      child: Text("Randomize"),
                    ),
                  ),
                ],
              ),
            ),
            filterView,
          ],
        ),
      ),
    );
  }
}
