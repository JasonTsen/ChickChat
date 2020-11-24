import 'dart:async';
import 'package:chickchat/Pattern/customInput.dart';
import 'package:chickchat/ProjectNAnnouncement/Announcement/add_announcement_confirmation.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAnnouncement extends StatefulWidget {

  const AddAnnouncement({Key key}) : super(key: key);

  @override
  State createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  _AddAnnouncementState({Key key});

  String _sender, _annContent, _annTitle, _relatedProject;
  bool viewed;

  Future<void> uploadFile() async {
    _announcementSetup(_annContent, _relatedProject, _sender, _annTitle, viewed);
    Toast.show("Announcement created successfully!", context,  duration: Toast.LENGTH_LONG);
    Navigator.pop(context);
  }

  Future <void> _announcementSetup (String content, String relatedProject, String sender, String title, bool viewed) async {
    FirebaseFirestore.instance.collection('Announcements')
        .add({
      'annContent': content,
      'relatedProject' : relatedProject,
      'sender' : sender,
      'title' : title,
      'viewed' : false,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      CustomInput(
                        onChanged: (value){
                          _annTitle = value;
                        },
                        hintText: "Announcement Title",
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      CustomInput(
                        onChanged: (value){
                          _annContent = value;
                        },
                        hintText: "Announcement Content",
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      CustomInput(
                        onChanged: (value){
                          _sender = value;
                        },
                        hintText: "Sender",
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      CustomInput(
                        onChanged: (value){
                          _relatedProject = value;
                        },
                        hintText: "Project Related",
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            uploadFile();
          },
          child: Text('Publish', style: new TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Add Announcement'),
      backgroundColor: Colors.grey,
      elevation: 0,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            var baseDialog = AddAnnouncementConfirmation(
              title: "Creating Announcement:",
              content: "Are you sure to quit now?",
              yesOnPressed: () {},
              noOnPressed: (){
                Navigator.of(context).pop();
              },
              yes: "Discard",
              no:"Cancel",
            );
            showDialog(context: context, builder: (BuildContext context) => baseDialog);
          }
      ),
    );
  }
}