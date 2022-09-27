import 'package:flutter/material.dart';
import 'package:mal_picker/filters_view.dart';
import '../custom_appbar.dart';
import '../custom_colors.dart';

class FilterScreen extends StatelessWidget {
  final FilterView filterView;

  const FilterScreen({Key? key, required this.filterView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: colorPalette[2],
        title: "Filters",
      ),
      body: SafeArea(
        child: Center(
          child: filterView,
        ),
      ),
    );
  }
}
