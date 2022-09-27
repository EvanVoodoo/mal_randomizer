import 'package:flutter/material.dart';
import 'package:mal_picker/screens/anime_popout_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Anime {
  late int id;
  late String title;
  late String mainPic;
  late List<dynamic> genres;
  late String rating;

  var startDate;
  var endDate;
  var synopsis;
  var mean;
  var startSeason;
  var startSeasonYear;

  Anime({
    required this.id,
    required this.title,
    required this.mainPic,
    required this.genres,
    required this.rating,
    this.startDate,
    this.endDate,
    this.synopsis,
    this.mean,
    this.startSeason,
    this.startSeasonYear,
  });

  Anime.empty();

  Anime.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"] ?? "Title not available.";
    mainPic = json["main_picture"]["large"] ?? "https://www.prestashop.com/sites/default/files/styles/blog_750x320/public/blog/2021/12/750x320-404-blog-postv2.png?itok=3oRUzCtD";
    genres = json["genres"] ?? ["Genres not available."];
    rating = json["rating"] ?? "Rating not available.";
    startDate = json["start_date"] ?? "Date not available.";
    endDate = json["end_date"] ?? "Date not available.";
    if (json["synopsis"] == "") {
      synopsis = "Synopsis not available.";
    } else {
      synopsis = json["synopsis"] ?? "Synopsis not available.";
    }
    mean = json["mean"] ?? "Score not available.";
    if (json["start_season"] == null) {
      startSeason = "Season aired not available.";
    } else {
      startSeason = json["start_season"]["season"] ?? "Season not available.";
      startSeasonYear = json["start_season"]["year"] ?? "Year not available.";
    }
  }

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

  Future<Anime> getAnimeDetails(
      int animeId, BuildContext context, Function onSuccess) async {
    final response = await http.get(
      Uri.parse(
          'https://api.myanimelist.net/v2/anime/${animeId}?fields=id,title,main_picture,genres,rating,start_date,end_date,synopsis,mean,start_season'),
      headers: <String, String>{
        'X-MAL-CLIENT-ID': "564c1c4a446e35f7ffd0e46898a7dc43"
      },
    );
    Anime x = Anime.fromJson(jsonDecode(response.body));
    onSuccess.call(x);
    return x;
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
                onPressed: () => anime.getAnimeDetails(
                  anime.id,
                  context,
                  (Anime x) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimePopOutScreen(anime: x),
                      ),
                    );
                  },
                ),
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
