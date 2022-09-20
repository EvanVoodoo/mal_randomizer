import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String title;

  const CustomAppBar({
    Key? key,
    required this.backgroundColor,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(54.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 26,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      elevation: 2,
    );
  }
}
