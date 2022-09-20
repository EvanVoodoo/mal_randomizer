import 'package:flutter/material.dart';
import './anime_view.dart';

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

class Node {
  final Map<String, dynamic> anime;

  Node({
    required this.anime,
  });

  Anime toAnime(anime) {
    Anime result = Anime.empty();
      result.id = anime["id"];
      result.title = anime["title"];
      result.mainPic = anime["main_picture"]["medium"];
    if (anime["rating"] == null && anime["genres"] == null) {
      result.genres = ["Data not found."];
      result.rating = "Data not found.";
    } else if (anime["rating"] == null) {
      result.genres = anime["genres"];
      result.rating = "Data not found.";
    } else if (anime["genres"] == null) {
      result.genres = ["Data not found."];
      result.rating = anime["rating"];
    } else {
      result.genres = anime["genres"];
      result.rating = anime["rating"];
    }
    return result;
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
          Expanded(
            flex: 1,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                ...animeList.animes.map((anime) {
                  return AnimeView(anime);
                }).toList(),
              ],
            ),
          ),
        ],
      );
    } else {
      return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: const [
          Text(
            "List currently empty.",
            style: TextStyle(
              fontSize: 32,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }
}
