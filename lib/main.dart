import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MalPicker());
}

class AnimeList {
  List<Anime> list = [];
  int userId = -1;

  AnimeList.list({
    required this.list,
  });

  AnimeList.userList({
    required this.list,
    required this.userId,
  });

  AnimeList.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      Node node = Node(anime: value);
      list.add(node.toAnime(node.anime));
    });
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
    );
  }
}

class Anime {
  final int id;
  final String title;

  Anime({
    required this.id,
    required this.title,
  });
}

List<Color> colorPalette = <Color>[
  const Color.fromRGBO(48, 84, 164, 1.0),
  const Color.fromRGBO(148, 181, 252, 1.0),
  const Color.fromRGBO(23, 40, 79, 1.0),
];

class MalPicker extends StatelessWidget {
  const MalPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MAL Picker",
      theme: ThemeData(
        primaryColor: colorPalette[0], //const Color.fromRGBO(48, 84, 164, 1),
        indicatorColor: colorPalette[1],
      ),
      home: Homepage("MAL Picker Homepage"),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage(this.title, {super.key});

  final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Tab> myTabs = <Tab>[
    const Tab(text: "LEFT"),
    const Tab(text: "CENTER"),
    const Tab(text: "RIGHT"),
  ];

  // TODO: Learn how to implement endpoints
  Future<AnimeList> fetchAnimeList() async {
    final response = await http.get(
      Uri.parse('https://api.myanimelist.net/v2/anime?q=undead&fields=id,title,main_picture,genres'),
      headers: <String, String>{'X-MAL-CLIENT-ID': "564c1c4a446e35f7ffd0e46898a7dc43"},
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return AnimeList.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load anime list: ' + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorPalette[0],
          title: Text(
            "MAL Picker",
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          children: myTabs.map((Tab tab) {
            final String? label = tab.text?.toLowerCase();
            return Center(
              child: Column(
                children: [
                  Text(
                    'This is the $label tab',
                    style: const TextStyle(fontSize: 36),
                  ),
                  ElevatedButton(
                    onPressed: () => print(fetchAnimeList().then((result) {
                      print(result);
                    })),
                    child: Text("I'm the $label tab button!\nClick me!"),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
