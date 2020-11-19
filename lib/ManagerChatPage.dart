import 'package:cached_network_image/cached_network_image.dart';
import 'package:chickchat/Pattern/design.dart';
import 'package:chickchat/Pattern/loading.dart';
import 'UserNDoc/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

import 'Controller/chatFirebase.dart';
import 'chatroom.dart';
class ManagerChat extends StatefulWidget {
  final String currentUserId;

  ManagerChat({Key key, @required this.currentUserId}) : super(key: key);

  @override
  State createState() => ManagerChatState(currentUserId: currentUserId);
}
class ManagerChatState extends State<ManagerChat> {

  ManagerChatState({Key key, @required this.currentUserId});
  String userId = "";
  final String currentUserId;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
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
        actions: [
          IconButton(
            iconSize: 40,
            padding: EdgeInsets.fromLTRB(
                10,10,20,10
            ),
            icon: Icon(Icons.search)
            ,
            onPressed: () {

            },
          ),
          IconButton(
            iconSize: 40,
            padding: EdgeInsets.fromLTRB(
                10,10,20,10
            ),
            icon: Icon(Icons.person)
            ,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UserProfile(currentUserId: auth.currentUser.uid)));
            },
          )

        ],

        title: Text(
          'Manager Page',
          style: TextStyle(color: Design.primaryColor, fontWeight: FontWeight.bold),
        ),

      ),

      body: Container(

        child: Stack(
          children: <Widget>[
            // List
            Container(
              child: StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection('Users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Design.themeColor),
                      ),
                    );
                  } else {

                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) =>
                          buildItem(context, snapshot.data.documents[index]),

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
                  onPressed: (){

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

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    if (document.data()['id'] == currentUserId) {
      return Container();
    } else {

      return Container(
        height: document.data()['uid'] != currentUserId
            ? 80.0
            : 0.0,
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Material(
                child: document.data()['userImg'] != null
                    ? CachedNetworkImage(
                  placeholder: (context, url) =>
                      Container(
                        child: CircularProgressIndicator(
                          strokeWidth: 1.0,
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.amber),
                        ),
                        width: 50.0,
                        height: 50.0,
                        padding: EdgeInsets.all(15.0),
                      ),
                  imageUrl: document.data()['userImg'],
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                )
                    : Icon(
                  Icons.account_circle,
                  size: 50.0,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${document.data()['name']}',
                          style: TextStyle(color: Colors.black),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          ' ${document.data()['role']}',
                          style: TextStyle(color: Colors.black),
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
                        Chat(
                          peerId: document.id,
                          peerName: document.data()['name'],
                          peerAvatar: document.data()['userImg'],
                        )));

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

}
class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}