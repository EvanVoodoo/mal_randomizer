import 'package:flutter/material.dart';
import 'package:mal_picker/custom_appbar.dart';
import 'package:mal_picker/custom_colors.dart';

import '../anime_view.dart';

class AnimePopOutScreen extends StatefulWidget {
  final Anime anime;

  const AnimePopOutScreen({Key? key, required this.anime}) : super(key: key);

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
        title: widget.anime.title,
        size: 70.0,
        font: 20.0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: SizedBox(
                    height: 240,
                    child: Image.network(anime.mainPic),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        anime.title,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
