import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/project_title_with_progressbar.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/task_color.dart';
import 'package:flutter/material.dart';
import 'description.dart';

class ProjectDetails extends StatelessWidget {
  final String id;
  final String collaborators;
  final String title;
  final int percentage;

  const ProjectDetails({
    Key key,
    @required
    this.id,
    this.collaborators,
    this.title,
    this.percentage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //to get current device's heights and width
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.25),
                  padding: EdgeInsets.only(
                    top: size.height * 0.03,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      TaskColor(),
                      Divider(color: Colors.black38),
                      Description(id: this.id),
                      Container(
                          margin: EdgeInsets.only(bottom:100),
                      ),
                    ],
                  ),
                ),
                ProjectTitleWithProgressBar(
                    collaborators: this.collaborators,
                    title: this.title,
                    percentage: this.percentage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
