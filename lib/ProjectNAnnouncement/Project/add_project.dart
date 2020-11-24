import 'dart:async';
import 'package:chickchat/Pattern/customInput.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/add_project_confirmation.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddProject extends StatefulWidget {

  const AddProject({
    Key key,
  }
  ) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddProject> {
  String _collaborators, _description, _projectTitle, _uploadImgFile;
  Color currentColor = Colors.limeAccent;
  double _currentSliderValue = 10;
  int selectedRad;

  void changeColor(Color color) => setState(() => currentColor = color);

  setSelectedRadio(int val){
    setState(() {
      selectedRad = val;
    });
  }

  void initState(){
    super.initState();
    selectedRad = 0;
  }

  Future<void> uploadFile() async {
    _projectSetup(_collaborators, (currentColor.toString()).substring(35,45), _description, _uploadImgFile, _projectTitle, _currentSliderValue.toInt());
    Toast.show("Project created successfully!", context,  duration: Toast.LENGTH_LONG);
    Navigator.pop(context);
  }

  Future <void> _projectSetup (String collaborators, String color, String description, String image, String projectTitle, int percentage) async {
    FirebaseFirestore.instance.collection('Projects')
        .add({
          'collaborators': collaborators,
          'color' : color,
          'description' : description,
          'image' : image,
          'title' : projectTitle,
          'percentage' : percentage,
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
                          _projectTitle = value;
                        },
                        hintText: "Project Title",
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
                          _description = value;
                        },
                        hintText: "Project Description",
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
                          _collaborators = value;
                        },
                        hintText: "Collaborators",
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select a color'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: currentColor,
                              onColorChanged: changeColor,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Confirm', style: new TextStyle(color: Colors.blueAccent, fontSize: 18)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Pick a color for your project'),
                  color: currentColor,
                  textColor: useWhiteForeground(currentColor)
                      ? const Color(0xffffffff)
                      : const Color(0xff000000),
                ),
                Divider(color: Colors.grey, endIndent: 20, indent: 20),
                Text("Project Progress:"),
                Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                    },
                ),
                Divider(color: Colors.grey, endIndent: 25, indent: 25),
                Text("Project Image:"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Radio(
                      activeColor: Color(0xffff80ac),
                      value: 1,
                      groupValue: selectedRad,

                      onChanged: (val){
                        setState(() {
                          _uploadImgFile = 'assets/images/icon_1.png';
                          setSelectedRadio(val);
                        });
                      },

                    ),
                    Text("Apple"),
                    Radio(
                      activeColor: Color(0xff26cc2c),
                      value: 2,
                      groupValue: selectedRad,
                      onChanged: (val){
                        _uploadImgFile = '/assets/images/icon_2.png';
                        setSelectedRadio(val);
                      },
                    ),
                    Text("Lemon"),
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
                        _uploadImgFile = 'assets/images/icon_3.png';
                        setSelectedRadio(val);
                      },
                    ),
                    Text("Pineapple"),
                    Radio(
                      activeColor: Color(0xffffd86f),
                      value: 4,
                      groupValue: selectedRad,
                      onChanged: (val){
                        _uploadImgFile = 'assets/images/icon_4.png';
                        setSelectedRadio(val);
                      },
                    ),
                    Text("Watermelon"),
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
            uploadFile();
          },
          child: Text('Create', style: new TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Create Project'),
      backgroundColor: Colors.grey,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          var baseDialog = AddProjectConfirmation(
            title: "Creating Project:",
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