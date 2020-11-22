import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chickchat/addOnlineApplication.dart';
import 'package:chickchat/onlineApplicationHistory.dart';

// ignore: must_be_immutable
class MyOnlineApplicationApp extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Application'),
        actions: [
          IconButton(icon: Icon(Icons.help_outline_sharp,color: Colors.black,size: 30,),
            onPressed: () =>  showDialog(
                context: context,
                builder: (context) => RulesAndRegulation(),
          ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 60.0),
            RaisedButton(
              onPressed: () => {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => AddOnlineApplication()))
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(30.0),
                child:
                const Text('Apply Online Application', style: TextStyle(fontSize: 30,),textAlign: TextAlign.center,),
              ),),
            SizedBox(height: 50.0),
            RaisedButton(
              onPressed: () => {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => OnlineApplicationHistory()))
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(30.0),
                child:
                const Text('View History Application', style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
              ),),
          ],
        ),
      ),
    );}
}
//-------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------

class RulesAndRegulation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Title(color: Colors.black, child: Text('Rules and Regulation for Online Application',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),),
      content: Flexible(
        child: Text('* Please apply all application 3 days before. We would contact you as soon as possible\n\n'
            '* Once the application submitted cannot be undo. Think wisely before send the online application form to us.',textAlign: TextAlign.left, style: TextStyle(fontSize: 16,color: Colors.red),
          overflow: TextOverflow.ellipsis,maxLines: 10,),
      ),
    );
  }
}