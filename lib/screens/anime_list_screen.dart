import 'dart:convert';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../anime_list_view.dart';
import '../anime_view.dart';
import '../custom_appbar.dart';
import '../custom_colors.dart';
import '../main.dart';
import 'filter_screen.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  Future<AnimeList> fetchAnimeList(int offset, String q) async {
    List<String> genres = filterView.activeGenreFilters;
    List<String> ratings = filterView.activeRatingFilters;
    bool nsfw = false;
    if (ratings.contains("rx")) nsfw = true;

    AnimeList aList = AnimeList();
    final response = await http.get(
      Uri.parse(
          'https://api.myanimelist.net/v2/anime?offset=$offset&q=$q&nsfw=$nsfw&fields=id,title,main_picture,genres,rating'),
      headers: <String, String>{
        'X-MAL-CLIENT-ID': "564c1c4a446e35f7ffd0e46898a7dc43"
      },
    );
    aList.merge(AnimeList.fromJson(jsonDecode(response.body)));
    if (response.statusCode == 200 && aList.animes.isNotEmpty) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(" \n$q");
      // Filter : Genres
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
    } else if (response.statusCode == 404 || aList.animes.isEmpty) {
      print(
          "Query  $q  gave no results, searching again. ${response.statusCode}");
      Random rnd = Random();
      String q2 = nouns.elementAt(rnd.nextInt(2537));
      return fetchAnimeList(0, q2);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load anime list: ${response.statusCode}');
    }
    if (aList.animes.length < 10 && offset < 90) {
      fetchAnimeList(offset + 10, q).then((result) {
        aList.merge(result);
      });
    }

    setState(() {});
    return aList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: colorPalette[0],
        title: "MAL Randomizer",
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: SizedBox(
                  height: 533.4,
                  child: AnimeListView(animeList),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPalette[0],
                    ),
                    onPressed: () {
                      Random rnd = Random();
                      String q = nouns.elementAt(rnd.nextInt(2537));
                      //print(
                      fetchAnimeList(0, q).then((result) {
                        //print(result.animes);
                        animeList = result;
                      }
                        //)
                      );
                    },
                    child: const SizedBox(
                      width: 71.0,
                      child: Text(
                        "Randomize",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPalette[0],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterScreen(
                            filterView: filterView,
                          ),
                        ),
                      );
                    },
                    child: const SizedBox(
                      width: 71.0,
                      child: Text(
                        "Filters",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
