import 'package:chickchat/Pattern/design.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(56); // set height of your choice

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Projects',
        style: TextStyle(color: Design.primaryColor, fontWeight: FontWeight.bold),
      ),

    );
  }
}