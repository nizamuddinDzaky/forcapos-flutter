import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      brightness: Brightness.light,
    );
  }

  @override
  Size get preferredSize => Size(0, 0);
}