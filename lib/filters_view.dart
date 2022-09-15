import "package:flutter/material.dart";
class FilterView extends StatefulWidget {
  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
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

  List<String> checkFilters() {
    List<String> list = [];
    for (var genre in genres) {
      if (genre["value"]) list.add(genre["name"]);
    }
    print(list);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          title: const Text("Genres"),
          subtitle:
          const Text("Filter your results to include the selected genres."),
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
                            print(e["value"]);
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
            Row(),
          ],
        ),
      ],
    );
  }
}




