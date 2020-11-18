import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/Pattern/design.dart';
import 'package:chickchat/ProjectNAnnouncement/Announcement/announcement_card.dart';
import 'package:chickchat/ProjectNAnnouncement/Announcement/announcement_details.dart';
import 'package:chickchat/models/Announcement.dart';
import 'package:chickchat/models/Project.dart';
import 'package:chickchat/models/Task.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({
    Key key,
    @required this.project,
    @required this.task,
    @required this.announcement,
  }) : super(key: key);

  final Project project;
  final Task task;
  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                  itemCount: announcements.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 4.0,
                  ),
                  itemBuilder: (context, index) => AnnouncementCard(
                    announcement: announcements[index],
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnnouncementDetails(
                            announcement: announcements[index],
                          ),
                        )),
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom:15),
          ),
        ],
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(
      'Announcement',
      style: TextStyle(color: Design.primaryColor, fontWeight: FontWeight.bold),
    ),
  );
}
