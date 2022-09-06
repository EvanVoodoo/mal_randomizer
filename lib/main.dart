import "package:flutter/material.dart";

void main() {
  runApp(MalPicker());
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
              child: Text(
                'This is the $label tab',
                style: const TextStyle(fontSize: 36),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
