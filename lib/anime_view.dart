import 'package:flutter/material.dart';

class Anime {
  final int id;
  final String title;
  final String mainPic;
  final List<dynamic> genres;

  Anime({
    required this.id,
    required this.title,
    required this.mainPic,
    required this.genres,
  });

  List<String> getGenres() {
    List<String> list = [];
    for (int i = 0; i < genres.length; i++) {
      list.add(genres[i]["name"]);
    }
    return list;
  }

  String printGenres() {
    String result = "";
    if (genres.isNotEmpty) {
      for (int i = 0; i < genres.length - 1; i++) {
        result += genres[i]["name"];
        result += ", ";
      }
      result += genres[genres.length - 1]["name"];
    }
    return result;
  }

  @override
  String toString() {
    var list = getGenres();
    return "\nAnime: $title id: $id\n Genres: $list";
  }
}

class AnimeView extends StatelessWidget {
  final Anime anime;

  AnimeView(this.anime);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 120,
                child: Image.network(anime.mainPic),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  anime.title,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  anime.id.toString(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
                Text(
                  anime.printGenres(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
