import 'dart:async';

import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/Pattern/design.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/collaborator.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/delete_task_confirmation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class TaskDetails extends StatefulWidget {

  const TaskDetails({
    Key key,
    @required this.id, this.projectId,
  }) : super(key: key);

  final String id;
  final String projectId;

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  String color, desc, docRequired, projectRelated, status, taskTitle;
  DateTime dueDate;

  String _status, _color;
  int selectedRad, _defaultRad;

  void initState(){
    super.initState();
    selectedRad = 0;
  }

  setSelectedRadio(int val){
    setState(() {
      selectedRad = val;
    }
    );
  }

  Future <void> changeStatus() async{
    _taskSetup(_color, _status);
  }

  Future <void> _taskSetup (String color,String status) async {
    FirebaseFirestore.instance.collection('Projects').doc(widget.projectId).collection("Tasks").doc(widget.id)
        .update({
      'color': color,
      'status' : status,
    });
  }

  Future<String> _changeStatus() async{
    try{
      await
      changeStatus();
      return null;
    }
    catch(e){
      return "Failed to change status!";
    }
  }

  _submitChange() async{
    String _awaitTask = await _changeStatus();

    if(_awaitTask != null){
      Toast.show("Failed to change status.", context,  duration: Toast.LENGTH_LONG);
    }else{
      Toast.show("Task status changed!", context,  duration: Toast.LENGTH_LONG);
      Navigator.pop(context);
    }
  }

  Future <void> _taskDelete () async {
    FirebaseFirestore.instance.collection('Projects')
        .doc(widget.projectId)
        .collection("Tasks")
        .doc(widget.id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Projects')
            .doc(widget.projectId)
            .collection('Tasks')
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot){
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Design.themeColor)
                )
            );
          } else {
            return buildCenter(snapshot.data);
          }
        }
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            _submitChange();
          },
          child: Text('Submit'),
        ),
      ),
    );
  }

  Widget buildCenter(DocumentSnapshot document){
    //defaultRad(document.data()['color']);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                padding: EdgeInsets.all(kDefaultPaddin),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(int.parse(document.data()['color'])),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Hero(
                  tag: "${'P01'}",
                  child: Text(document.data()['taskTitle'], style: new TextStyle(color:Colors.white)),
                ),
              ),
            ),
            Divider(color: Colors.black),
            Row(
              children: [
                Text(
                  'Task Name: ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Spacer(),
                Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Text(
                    document.data()['taskTitle'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.black),
            Row(
              children: [
                Text(
                  'Due Date: ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Spacer(),
                Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Text(
                    DateFormat('d MMMM y').format((document.data()['dueDate']).toDate()),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Divider(color: Colors.black),
            Row(
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
                      content: document.data()['docRequired'],
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
                        document.data()['docRequired'],
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
                      content: document.data()['desc'],
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
                        document.data()['desc'],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Radio(
                  activeColor: Color(0xffff80ac),
                  value: 1,
                  groupValue: selectedRad,

                  onChanged: (val){
                    setState(() {
                      _color = "0xffff80ac";
                      _status = "To Do";
                      setSelectedRadio(val);
                    });
                  },

                ),
                Text("To Do"),
                Radio(
                  activeColor: Color(0xff26cc2c),
                  value: 2,
                  groupValue: selectedRad,
                  onChanged: (val){
                    _color = "0xff26cc2c";
                    _status = "Done";
                    setSelectedRadio(val);
                  },
                ),
                Text("Done"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Radio(
                  activeColor: Color(0xff7ee1ff),
                  value: 3,
                  groupValue: selectedRad,
                  onChanged: (val){
                    _color = "0xff7ee1ff";
                    _status = "In Progress";
                    setSelectedRadio(val);
                  },
                ),
                Text("In Progress"),
                Radio(
                  activeColor: Color(0xffffd86f),
                  value: 4,
                  groupValue: selectedRad,
                  onChanged: (val){
                    _color = "0xffffd86f";
                    _status = "Rejected";
                    setSelectedRadio(val);
                  },
                ),
                Text("Rejected"),
              ],
            ),
          ],
        ),
      ),
    );
}
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Task Details'),
      backgroundColor: Colors.black45,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.delete, size: 30),
          onPressed: () {
            var baseDialog = DeleteTaskConfirmation(
              title: "Delete Task:",
              content: "Are you sure to delete this task?",
              yesOnPressed: () {
                _taskDelete();
                Toast.show("Task deleted!", context,  duration: Toast.LENGTH_LONG);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              noOnPressed: (){},
              yes: "Delete",
              no:"Cancel",
            );
            showDialog(context: context, builder: (BuildContext context) => baseDialog);
          },
        ),
        SizedBox(width: kDefaultPaddin / 2),
      ],
    );
  }
}