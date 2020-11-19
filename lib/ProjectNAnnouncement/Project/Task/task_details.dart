import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/collaborator.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/task_status.dart';
import 'package:chickchat/models/Project.dart';
import 'package:chickchat/models/Task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaskDetails extends StatelessWidget {

  const TaskDetails({
    Key key,
    @required this.task, this.project,
  }) : super(key: key);

  final Task task;
  final Project project;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  padding: EdgeInsets.all(kDefaultPaddin),
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
              Divider(color: Colors.black),
              Row(
                children: [
                  Text(
                    'Task Name: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black),
              Row(
                children: [
                  Text(
                    'Due Date: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      task.dueDate,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black),
              Row(
                children: [
                  Text(
                    'Document Required: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      var baseDialog = BaseAlertDialog(
                        title: "Documents Required:",
                        content: task.docRequired,
                        yesOnPressed: () {},
                        yes: "Close",
                      );
                      showDialog(context: context, builder: (BuildContext context) => baseDialog);
                    },
                    child: SizedBox(
                      width: 160.0,
                      child: Container(
                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Text(
                          task.docRequired,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black),
              Row(
                children: [
                  Text(
                    'Description: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      var baseDialog = BaseAlertDialog(
                        title: "Task Description:",
                        content: task.desc,
                        yesOnPressed: () {},
                        yes: "Close",
                      );
                      showDialog(context: context, builder: (BuildContext context) => baseDialog);
                    },
                    child: SizedBox(
                      width: 200.0,
                      child: Container(
                        padding: new EdgeInsets.only(right: 15.0),
                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Text(
                          task.desc,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Task Status: ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              MyTaskStatus(), //Radio button list to select task status
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Submit'),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Task Details'),
      backgroundColor: Colors.grey,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      /*actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg"),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],*/
    );
  }
}