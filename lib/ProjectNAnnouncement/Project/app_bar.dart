import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/Pattern/design.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/add_project.dart';
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
      actions: <Widget>[
        IconButton(
          icon: new Icon(Icons.add, size: 30),
          iconSize: 33.0,
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddProject(),
              )),
        ),
        SizedBox(width: kDefaultPaddin / 2),
      ],
    );
  }
}