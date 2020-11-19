import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/body.dart';
import 'package:chickchat/models/Project.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Project project;

  const DetailsScreen({Key key, this.project}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: project.color,
      appBar: buildAppBar(context),
      body: Body(project: project),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: project.color,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        /*IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),*/
        IconButton(
          icon: new Icon(Icons.add, color: Colors.white),
          iconSize: 33.0,
          /*onPressed: () => Navigator.push(
              context,`
              MaterialPageRoute(
                builder: (context) => {}( //will route to task_details
                  //project: products[index],
                ),
              )),*/
        ),
        SizedBox(width: kDefaultPaddin / 2),
      ],
    );
  }
}
