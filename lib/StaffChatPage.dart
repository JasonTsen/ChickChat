import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StaffChat extends StatefulWidget{
  @override
  _StaffChatState createState() => new _StaffChatState();
}

class _StaffChatState extends State<StaffChat>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text ('StaffChatPage'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async{
            await FirebaseAuth.instance.signOut();
          },
          child: Text("Sign Out"),
        ),

      ),
    );

  }
}