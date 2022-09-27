import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mal_picker/custom_appbar.dart';
import 'package:mal_picker/custom_colors.dart';
import 'package:http/http.dart' as http;

import '../anime_view.dart';

class AnimePopOutScreen extends StatefulWidget {
  final Anime anime;

  const AnimePopOutScreen({
    Key? key,
    required this.anime,
  }) : super(key: key);

  Future<Anime> getAnimeDetails() async {
    final response = await http.get(
      Uri.parse(
          'https://api.myanimelist.net/v2/anime/${anime
              .id}?fields=id,title,main_picture,genres,rating,start_date,end_date,synopsis,mean,start_season'),
      headers: <String, String>{
        'X-MAL-CLIENT-ID': "564c1c4a446e35f7ffd0e46898a7dc43"
      },
    );
    Anime x = Anime.fromJson(jsonDecode(response.body));
    return x;
  }

  @override
  State<AnimePopOutScreen> createState() => _AnimePopOutScreenState();
}

class _AnimePopOutScreenState extends State<AnimePopOutScreen> {
  @override
  Widget build(BuildContext context) {
    Anime anime = widget.anime;

    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: colorPalette[2],
        title: anime.title,
        size: 70.0,
        font: 20.0,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 94.0,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: SizedBox(
                        height: 240,
                        width: 175,
                        child: Image.network(anime.mainPic),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 12.0, right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ID: ${anime.id.toString()}",
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              anime.title,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 5,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(
                            anime.printGenres(),
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            maxLines: 10,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Rated: ${anime.getRating.toUpperCase()}",
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            maxLines: 1,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${anime.mean} / 10",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      //Synopsis Section
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Aired: ${anime.startSeason[0].toUpperCase() +
                                  anime.startSeason.substring(1)} ${anime
                                  .startSeasonYear}",
                            ),
                            Text(
                              "Start Date: ${anime.startDate}",
                            ),
                            Text(
                              "End Date: ${anime.endDate}",
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6.0),),
                            const Divider(
                              thickness: 1,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
                              child: Text(
                                "Synopsis",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: SingleChildScrollView(
                                  child: Text(
                                    anime.synopsis,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.fade,
                                    softWrap: true,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
