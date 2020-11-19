import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/models/Project.dart';
import 'package:chickchat/models/Task.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Project project;
  final Task task;
  final Function press;
  const TaskCard({
    Key key,
    this.project,
    this.task,
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
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: task.color,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Hero(
                tag: "${task.id}",
                child: Text(task.title, style: new TextStyle(color:Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
