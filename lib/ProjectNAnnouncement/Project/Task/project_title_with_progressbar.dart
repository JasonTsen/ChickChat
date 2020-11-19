import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/collaborator.dart';
import 'package:chickchat/models/Project.dart';
import 'package:chickchat/models/Task.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProjectTitleWithProgressBar extends StatelessWidget {
  const ProjectTitleWithProgressBar({
    Key key,
    @required this.project, this.task,
  }) : super(key: key);

  final Project project;
  final Task task;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Project Details",
            style: TextStyle(color: Colors.white),
          ),
          GestureDetector(
            onTap: () async {
              var baseDialog = BaseAlertDialog(
                title: "Project Title:",
                content: project.title,
                yesOnPressed: () {},
                yes: "Close",
              );
              showDialog(context: context, builder: (BuildContext context) => baseDialog);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 4.0),
              child: Text(
                project.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 70,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 1100,
                  percent: (project.percentage / 100), //percentage variable
                  center: Text(project.percentage.toString() + "%"), //percentage variable
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.greenAccent,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  //Vibration.vibrate(duration: 100, amplitude: 1);

                  var baseDialog = BaseAlertDialog(
                      title: "Project Collaborators:",
                      content: project.collaborators,
                      yesOnPressed: () {},
                      yes: "Close",
                  );
                  showDialog(context: context, builder: (BuildContext context) => baseDialog);
                },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Tap to see collaborators...', style: new TextStyle(color:Colors.white)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}