
import 'package:chickchat/Pattern/design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OnlineApplicationHistoryView extends StatefulWidget {
  OnlineApplicationHistoryView({Key key, @required this.formType, @required this.reason}) : super(key: key);
  final formType;
  final reason;

  @override
  State createState() => OnlineApplicationHistoryState();
}

class OnlineApplicationHistoryState extends State<OnlineApplicationHistoryView> {

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
          widget.formType,
          style: TextStyle(color: Design.primaryColor, fontWeight: FontWeight.bold),
        ),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Icon(IconData(59047, fontFamily: 'MaterialIcons'),size: 50,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Flexible(child: Text(widget.reason,style: TextStyle(fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 6,),),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
