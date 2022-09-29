import "package:flutter/material.dart";
import 'package:mal_picker/screens/anime_list_screen.dart';
import "anime_list_view.dart";
import 'filters_view.dart';
import 'custom_colors.dart';

void main() {
  runApp(const MalPicker());
}

class MalPicker extends StatelessWidget {
  const MalPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MAL Randomizer",
      theme: ThemeData(
        primaryColor: colorPalette[0],
        indicatorColor: colorPalette[1],
      ),
      home: const Homepage("MAL Randomizer Homepage"),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage(this.title, {super.key});

  final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

AnimeList animeList = AnimeList();
FilterView filterView = FilterView();

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return const AnimeListScreen();
  }
}
