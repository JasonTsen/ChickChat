import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/add_task.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/collaborator.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/project_details.dart';
import 'package:flutter/material.dart';

class DetailsBuilder extends StatelessWidget {
  final String id;
  final String collaborators;
  final String title;
  final int percentage;
  final String color;
  final String description;

  const DetailsBuilder({
    Key key,
    this.id,
    this.collaborators,
    this.title,
    this.percentage,
    this.color,
    this.description,
  }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse(color)),
      appBar: buildAppBar(context),
      body: ProjectDetails(
        id: this.id,
        collaborators: this.collaborators,
        title: this.title,
        percentage: this.percentage,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(int.parse(color)),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: new Icon(Icons.add, color: Colors.white),
          iconSize: 33.0,
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddTask(id: this.id),
              )),
        ),
        IconButton(
          icon: Icon(Icons.info_outline, color: Colors.white, size: 30),
          onPressed: () {
            var baseDialog = BaseAlertDialog(
              title: "Project Description:",
              content: description,
              yesOnPressed: () {},
              yes: "Close",
            );
            showDialog(context: context, builder: (BuildContext context) => baseDialog);
          },
        ),
        SizedBox(width: kDefaultPaddin / 2),
      ],
    );
  }
}
