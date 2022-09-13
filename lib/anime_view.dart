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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              child: Image.network(anime.mainPic),
              height: 120,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(anime.title),
            Text(anime.id.toString()),
          ],
        ),
      ],
    );
  }
}
