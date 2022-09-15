import 'package:flutter/material.dart';

class Anime {
  final int id;
  final String title;
  final String mainPic;

  Anime({
    required this.id,
    required this.title,
    required this.mainPic,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "Anime: $title id: $id\n";
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
                Text(anime.id.toString()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
