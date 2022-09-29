import 'package:flutter/material.dart';
import 'anime_view.dart';
import 'node.dart';

class AnimeList {
  List<Anime> animes = [];

  AnimeList();

  AnimeList.animes({
    required this.animes,
  });

  AnimeList.fromJson(Map<String, dynamic> json) {
    if (json["data"].runtimeType != Null) {
      List<dynamic> data = json["data"];
      for (var value in data) {
        value.forEach((key, value) {
          Node node = Node(anime: value);
          animes.add(node.toAnime(node.anime));
        });
      }
    }
  }

  void merge(AnimeList aList) {
    animes = animes + aList.animes;
  }
}

class AnimeListView extends StatelessWidget {
  final AnimeList animeList;

  AnimeListView(this.animeList);

  @override
  Widget build(BuildContext context) {
    if (animeList.animes.isNotEmpty) {
      return Column(
        children: [
          ...animeList.animes.map((anime) {
            return AnimeView(anime);
          }).toList(),
        ],
      );
    } else {
      return const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "Welcome to the MAL Randomizer!\n\n"
            "Using this app you can get random a set of anime from the MAL database. "
            "Just press the randomize button at the bottom left of the screen!\n"
            "You can also filter the anime given by both genre and age rating!\n"
            "To access that screen, just click the button at the bottom right of the screen!\n"
            "If you want to see more details about an anime, press the anime's image on the left!\n",
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ));
    }
  }
}
