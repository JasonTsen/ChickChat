import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/project_title_with_progressbar.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/task_color.dart';
import 'package:chickchat/models/Project.dart';
import 'package:chickchat/models/Task.dart';
import 'package:flutter/material.dart';
import 'description.dart';

class Body extends StatelessWidget {
  final Project project;
  final Task task;

  const Body({Key key, this.project, this.task}) : super(key: key);
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
                      TaskColor(project: project),
                      //SizedBox(width: MediaQuery.of(context).size .width, height: kDefaultPaddin / 1),
                      Divider(color: Colors.black38),
                      Description(task: task),
                      Container(
                          margin: EdgeInsets.only(bottom:100),
                      ),
                      //Text('Project Started', style: new TextStyle(margin: EdgeInsets.only(top: size.height * 0.25)),),
                      //Divider(color: Colors.black54),
                      //padding: const EdgeInsets.only(bottom: 90),
                    ],
                  ),
                ),
                ProjectTitleWithProgressBar(project: project)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
