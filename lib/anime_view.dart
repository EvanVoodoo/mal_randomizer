import 'package:flutter/material.dart';
import 'package:mal_picker/screens/anime_popout_screen.dart';

class Anime {
  late int id;
  late String title;
  late String mainPic;
  late List<dynamic> genres;
  late String rating;

  Anime({
    required this.id,
    required this.title,
    required this.mainPic,
    required this.genres,
    required this.rating,
  });

  Anime.empty();

  List<String> get getGenres {
    List<String> list = [];
    for (int i = 0; i < genres.length; i++) {
      list.add(genres[i]["name"]);
    }
    return list;
  }

  String get getRating => rating;

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
    return "\nAnime: $title id: $id\n Genres: $getGenres\n Rating: $getRating";
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimePopOutScreen(anime: anime),
                    ),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(0.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    height: 120,
                    child: Image.network(anime.mainPic),
                  ),
                ),
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
