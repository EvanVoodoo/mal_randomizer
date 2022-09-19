import "package:flutter/material.dart";

class FilterView extends StatefulWidget {
  List<String> _activeGenreFilters = [];
  List<String> _activeRatingFilters = [
    "g",
    "pg",
    "pg_13",
    "r",
  ];

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
      "name": "g",
      "show_name": "G - All Ages",
      "value": true,
    },
    {
      "name": "pg",
      "show_name": "PG - Children",
      "value": true,
    },
    {
      "name": "pg_13",
      "show_name": "PG-13 - Teens 13 or older",
      "value": true,
    },
    {
      "name": "r",
      "show_name": "R - 17+",
      "value": true,
    },
  ];

  List<Map<String, dynamic>> nsfwRatings = [
    {
      "name": "r+",
      "show_name": "R+ - Mild Nudity",
      "value": false,
    },
    {
      "name": "rx",
      "show_name": "Hentai",
      "value": false,
    },
  ];

  List<String> get activeGenreFilters => _activeGenreFilters;

  List<String> get activeRatingFilters => _activeRatingFilters;

  void activateFilter(String filter, String type) {
    switch (type.toLowerCase()) {
      case "genres":
      case "genre":
        {
          if (!_activeGenreFilters.contains(filter)) {
            _activeGenreFilters.add(filter);
          }
        }
        break;
      case "ratings":
      case "rating":
        {
          if (!_activeRatingFilters.contains(filter)) {
            _activeRatingFilters.add(filter);
          }
        }
        break;
      default:
        {}
    }
  }

  void deactivateFilter(String filter, String type) {
    switch (type.toLowerCase()) {
      case "genres":
      case "genre":
        {
          if (_activeGenreFilters.contains(filter)) {
            _activeGenreFilters.remove(filter);
          }
        }
        break;
      case "ratings":
      case "rating":
        {
          if (_activeRatingFilters.contains(filter)) {
            _activeRatingFilters.remove(filter);
          }
        }
        break;
      default:
        {}
    }
  }

  @override
  State<FilterView> createState() => _FilterViewState(this);
}

class _FilterViewState extends State<FilterView> {
  FilterView filterView;

  _FilterViewState(this.filterView);

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
                ...filterView.genres.map((e) {
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
                                if (e["value"]) {
                                  filterView.activateFilter(e["name"], "genre");
                                } else {
                                  filterView.deactivateFilter(
                                      e["name"], "genre");
                                }
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
                ...filterView.ratings.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(e["show_name"]),
                        ),
                        SizedBox(
                          width: 50,
                          child: Checkbox(
                            value: e["value"],
                            onChanged: (value) {
                              setState(() {
                                e["value"] = value;
                                if (e["value"]) {
                                  filterView.activateFilter(
                                      e["name"], "rating");
                                } else {
                                  filterView.deactivateFilter(
                                      e["name"], "rating");
                                }
                                print(e["name"] + ": " + e["value"].toString());
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 28.0),
                  child: ExpansionTile(
                    title: const Text(
                      "NSFW Ratings",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    subtitle: const Text("Always off by default."),
                    children: [
                      ...filterView.nsfwRatings.map((e) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 22.0, right: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(e["show_name"]),
                              ),
                              SizedBox(
                                width: 50,
                                child: Checkbox(
                                  value: e["value"],
                                  onChanged: (value) {
                                    setState(() {
                                      e["value"] = value;
                                      // if (e["value"]) {
                                      //   filterView.activateFilter(
                                      //       e["name"], "rating");
                                      // } else {
                                      //   filterView.deactivateFilter(
                                      //       e["name"], "rating");
                                      // }
                                      print(e["name"] +
                                          ": " +
                                          e["value"].toString());
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
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}