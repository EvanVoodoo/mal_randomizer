import 'package:flutter/material.dart';
import './anime_view.dart';

class AnimeList {
  List<Anime> list = [];
  int userId = -1;

  AnimeList();

  AnimeList.list({
    required this.list,
  });

  AnimeList.userList({
    required this.list,
    required this.userId,
  });

  AnimeList.fromJson(Map<String, dynamic> json) {
    if (json["data"].runtimeType != Null) {
      List<dynamic> data = json["data"];
      // List<Map<String, Map<String, dynamic>>> data = json["data"];
      for (var value in data) {
        value.forEach((key, value) {
          Node node = Node(anime: value);
          list.add(node.toAnime(node.anime));
        });
      }
    }
  }
}

class Node {
  final Map<String, dynamic> anime;

  Node({
    required this.anime,
  });

  Anime toAnime(anime) {
    return Anime(
      id: anime["id"],
      title: anime["title"],
      mainPic: anime["main_picture"]["medium"],
      genres: anime["genres"],
    );
  }
}

class AnimeListView extends StatelessWidget {
  final AnimeList animeList;

  AnimeListView(this.animeList);

  @override
  Widget build(BuildContext context) {
    if (animeList.list.isNotEmpty) {
      return Expanded(
        flex: 1,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            ...animeList.list.map((anime) {
              return AnimeView(anime);
            }).toList(),
          ],
        ),
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
