import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/models/Project.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Project project;
  final Function press;
  const ItemCard({
    Key key,
    this.project,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: project.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${project.id}",
                child: Image.asset(project.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              project.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
