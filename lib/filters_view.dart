import "package:flutter/material.dart";

class FilterView extends StatefulWidget {
  List<String> _activeFilters = [];

  List<Map<String, dynamic>> genres = [
    {
      "name": "Action",
      "value": false,
    },
    {
      "name": "Comedy",
      "value": false,
    },
    {
      "name": "Romance",
      "value": false,
    },
    {
      "name": "Shounen",
      "value": false,
    },
    {
      "name": "Seinen",
      "value": false,
    },
    {
      "name": "Shoujo",
      "value": false,
    },
    {
      "name": "Adventure",
      "value": false,
    },
    {
      "name": "Slice of Life",
      "value": false,
    },
  ];

  List<Map<String, dynamic>> ratings = [
    {
      "name": "G - All Ages",
      "value": false,
    },
    {
      "name": "PG - Children",
      "value": false,
    },
    {
      "name": "PG-13 - Teens 13 or older",
      "value": false,
    },
    {
      "name": "R - 17+",
      "value": false,
    },
    {
      "name": "NSFW", // R+ - Mild Nudity & Rx - Hentai
      "value": false,
    },
  ];

  List<String> getActiveFilters() {
    return _activeFilters;
  }

  void activateFilter(String filter) {
    if (!_activeFilters.contains(filter)) {
      _activeFilters.add(filter);
    }
  }

  void deactivateFilter(String filter) {
    if (_activeFilters.contains(filter)) {
      _activeFilters.remove(filter);
    }
  }

  @override
  State<FilterView> createState() =>
      _FilterViewState(_activeFilters, genres, ratings);
}

class _FilterViewState extends State<FilterView> {
  List<String> activeFilters = [];
  List<Map<String, dynamic>> genres;
  List<Map<String, dynamic>> ratings;

  _FilterViewState(this.activeFilters, this.genres, this.ratings);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            ExpansionTile(
              title: const Text("Genres"),
              subtitle: const Text(
                  "Filter your results to include the selected genres."),
              children: [
                ...genres.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(e["name"]),
                        ),
                        SizedBox(
                          width: 50,
                          child: Checkbox(
                            value: e["value"],
                            onChanged: (value) {
                              setState(() {
                                e["value"] = value;
                                if (e["value"]) activeFilters.add(e["name"]);
                                else activeFilters.remove(e["name"]);
                                print(e["name"] + ": " + e["value"].toString());
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            ExpansionTile(
              title: const Text("Age Ratings"),
              subtitle: const Text(
                  "Filter your results to include the selected age ratings."),
              children: [
                ...ratings.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(e["name"]),
                        ),
                        SizedBox(
                          width: 50,
                          child: Checkbox(
                            value: e["value"],
                            onChanged: (value) {
                              setState(() {
                                e["value"] = value;
                                print(e["name"] + ": " + e["value"].toString());
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
