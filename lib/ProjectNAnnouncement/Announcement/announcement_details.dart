import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/Pattern/design.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnnouncementDetails extends StatelessWidget {
  final String annContent;
  final String receiver;
  final String relatedProject;
  final String sender;
  final String title;
  final bool viewed;

  const AnnouncementDetails({
    Key key, this.annContent, this.receiver, this.relatedProject, this.sender, this.title, this.viewed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    CollectionReference projects = FirebaseFirestore.instance.collection('Projects');

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
                    margin: const EdgeInsets.only(top: 13.0, bottom: 5.0),
                    child: Text(
                      title,
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
                  Text ('Contents:', style: new TextStyle(fontSize: 18)),
                ],
              ),
              Divider(color: Colors.white),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: new Text(
                        annContent,
                        style: new TextStyle()
                    ),
                  ),
                )
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Divider(color: Colors.black),
                    FutureBuilder(
                      future: projects.doc(relatedProject).get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Design.themeColor),
                            ),
                          );
                        }
                        else {
                          Map<String, dynamic> data = snapshot.data.data();
                          return Text("${data['title']}");
                        }
                      },
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
            ],
          ),
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
