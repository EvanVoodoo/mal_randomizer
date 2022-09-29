import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String title;
  double size;
  double font;

  CustomAppBar({
    Key? key,
    required this.backgroundColor,
    required this.title,
    this.size = 54.0,
    this.font = 26.0,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(size);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 56.0, right: 16.0, bottom: 20.0),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          maxLines: 1,
          style: TextStyle(
            fontSize: font,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      elevation: 2,
    );
  }
}
