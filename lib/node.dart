import 'anime_view.dart';

class Node {
  final Map<String, dynamic> anime;

  Node({
    required this.anime,
  });

  Anime toAnime(anime) {
    Anime result = Anime.empty();
    result.id = anime["id"];
    result.title = anime["title"];
    result.mainPic = anime["main_picture"]["medium"] ?? "https://www.prestashop.com/sites/default/files/styles/blog_750x320/public/blog/2021/12/750x320-404-blog-postv2.png?itok=3oRUzCtD";
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

  Anime toAnimeDetails(anime) {
    Anime result = Anime.empty();
    result.id = anime["id"];
    result.title = anime["title"];
    result.mainPic = anime["main_picture"]["medium"];
    if (anime["genres"] == null) {
      result.genres = ["Data not found."];
    } else {
      result.genres = anime["genres"];
    }
    if (anime["rating"] == null) {
      result.rating = "Data not found.";
    } else {
      result.rating = anime["rating"];
    }
    return result;
  }
}