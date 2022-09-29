import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final Color backgroundColor;
  final String title;

  const CustomSliverAppBar({
    Key? key,
    required this.backgroundColor,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      snap: false,
      expandedHeight: 240,
      backgroundColor: backgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 16),
        centerTitle: true,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24),
        ),
        background: Opacity(
          opacity: 0.9,
          child: Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOsk3pi8uK6L7FieYUHy866znTnI-AqoDImg&usqp=CAU",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
