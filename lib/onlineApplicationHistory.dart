
import 'package:chickchat/Pattern/design.dart';
import 'package:chickchat/onlineApplicationHistoryView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OnlineApplicationHistory extends StatefulWidget {
  final String currentUserId;
  OnlineApplicationHistory({Key key, @required this.currentUserId}) : super(key: key);

  @override
  State createState() => OnlineApplicationHistoryState(currentUserId: currentUserId);
}
class OnlineApplicationHistoryState extends State<OnlineApplicationHistory> {
  OnlineApplicationHistoryState({Key key, @required this.currentUserId});

  final String currentUserId;
  @override
  void initState() {

    super.initState();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        //automaticallyImplyLeading: false,

        title: Text(
          'Online Application History',
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
                FirebaseFirestore.instance.collection('applicationForm').doc(auth.currentUser.uid).collection(auth.currentUser.uid).snapshots(),
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

            // Loading
          ],
        ),

      ),

    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
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
                          DateFormat('dd MMM kk:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(document.data()['applyDate']))),
                          style: TextStyle(color: Colors.black),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          ' ${document.data()['formType']}',
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => OnlineApplicationHistoryView(formType:document.data()['formType'],reason:document.data()['reason'])));
          },
          color: Colors.grey,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}