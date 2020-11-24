import 'dart:async';

import 'package:chickchat/Pattern/customInput.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/add_task_confirmation.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  final String id;

  const AddTask({
    Key key,
    this.id,
  }
  ) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _taskTitle, _desc, _docRequired, _color, _status, _projectRelated;
  int selectedRad;
  DateTime _dueDate;

  void initState(){
    super.initState();
    selectedRad = 0;
    _dueDate = DateTime.now();
  }

  setSelectedRadio(int val){
    setState(() {
      selectedRad = val;
    });
  }

  Future <void> uploadTask() async{
    _taskSetup(_color, _desc,_docRequired, _dueDate, _projectRelated, _status, _taskTitle);
  }

  Future <void> _taskSetup (String color, String desc, String docRequired, DateTime dueDate, String projectRelated, String status, String taskTitle) async {
    FirebaseFirestore.instance.collection('Projects').doc(widget.id).collection("Tasks")
        .add({
          'color': color,
          'desc' : desc,
          'docRequired' : docRequired,
          'dueDate' : dueDate,
          'projRelated' : widget.id,
          'status' : status,
          'taskTitle' : taskTitle,
        });
  }

  Future<String> _createTask() async{
    try{
      await
      uploadTask();
      return null;
    }
    catch(e){
      return "Failed to create task!";
    }
  }

  _submitCreate() async{
    Timer _timer;
    String _awaitTask = await _createTask();

    if(_awaitTask != null){
      Toast.show("Failed to create task.", context,  duration: Toast.LENGTH_LONG);
    }else{
      Toast.show("Task created successfully!", context,  duration: Toast.LENGTH_LONG);
      Navigator.pop(context);
    }
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
                          _taskTitle = value;
                        },
                        hintText: "Task Name",
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
                          _desc = value;
                        },
                        hintText: "Task Description",
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
                          _docRequired = value;
                        },
                        hintText: "Document Required",
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text("Pick task due date (Tap me):"),
                  subtitle: Text("${_dueDate.year} - ${_dueDate.month} - ${_dueDate.day}"),
                  onTap: ()async{
                    DateTime picked = await showDatePicker(context: context, initialDate: _dueDate, firstDate: DateTime(_dueDate.year-5), lastDate: DateTime(_dueDate.year+5));

                    if(picked != null) {
                      setState(() {
                        _dueDate = picked;
                      });
                    }
                  },
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
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            _submitCreate();
          },
          child: Text('Submit', style: new TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Create Task'),
      backgroundColor: Colors.grey,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          var baseDialog = AddTaskConfirmation(
            title: "Creating Task:",
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