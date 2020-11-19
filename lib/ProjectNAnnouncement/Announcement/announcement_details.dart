import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/Pattern/design.dart';
import 'package:chickchat/models/Announcement.dart';
import 'package:chickchat/models/Project.dart';
import 'package:chickchat/models/Task.dart';
import 'package:flutter/material.dart';

class AnnouncementDetails extends StatelessWidget {

  const AnnouncementDetails({
    Key key,
    @required this.task, this.project, this.announcement,
  }) : super(key: key);

  final Task task;
  final Project project;
  final Announcement announcement;

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                    child: Text(
                      announcement.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Text ('Contents:', style: new TextStyle(fontSize: 18, decoration: TextDecoration.underline,)),
                ],
              ),
              Divider(color: Colors.white),
              Expanded(
                child: new SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: new Text(
                    announcement.annContent,
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Column(
                children:<Widget>[
                  Text (announcement.relatedProject),
                ],
              ),
              /*Row(
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
              MyTaskStatus(), //Radio button list to select task status*/
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
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Announcement Details',
        style: TextStyle(color: Design.primaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}