import 'package:chickchat/Pattern/design.dart';
import 'package:chickchat/Pattern/loading.dart';
import 'package:chickchat/ProjectNAnnouncement/Announcement/announcement_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatefulWidget {

  AnnouncementScreen({Key key}) : super(key: key);

  @override
  State createState() => AnnouncementScreenState();
}
class AnnouncementScreenState extends State<AnnouncementScreen> {
  AnnouncementScreenState({Key key});

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Announcements',
          style: TextStyle(
              color: Design.primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            // List
            Container(
              child: StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection('Announcements')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Design.themeColor),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) =>
                          announcementCard(
                              context, snapshot.data.documents[index]
                          ),
                      itemCount: snapshot.data.documents.length,
                    );
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0, left: 300.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {

                  },
                  child: Icon(Icons.add),
                ),
              ),
            ),

            // Loading
            Positioned(
              child: isLoading ? const Loading() : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget announcementCard(BuildContext context, DocumentSnapshot document) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${document.data()['title']}',
                        style: TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                    Container(
                      child: Text(
                        'sender: ' + ' ${document.data()['sender']}',
                        style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 20.0),
              ),
            ),

          ],
        ),

        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AnnouncementDetails(
                          annContent: document.data()['annContent'],
                          receiver: document.data()['receiver'],
                          relatedProject: document.data()['relatedProject'],
                          sender: document.data()['sender'],
                          title: document.data()['title'],
                          viewed: document.data()['viewed'],
                      )
              )
          );
        },
        color: Design.greyColor,
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),

      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),

    );
  }
}