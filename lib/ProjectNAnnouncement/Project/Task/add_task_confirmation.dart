import 'package:flutter/material.dart';

class AddTaskConfirmation extends StatelessWidget {
  Color _color = Colors.white;

  String _title;
  String _content;
  String _yes;
  String _no;
  Function _yesOnPressed;
  Function _noOnPressed;


  AddTaskConfirmation({String title, String content, Function yesOnPressed, Function noOnPressed, String yes = "Yes", String no = "No"}){
    this._title = title;
    this._content = content;
    this._yesOnPressed = yesOnPressed;
    this._yes = yes;
    this._noOnPressed = _noOnPressed;
    this._no = no;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(this._title),
      content: new SingleChildScrollView(
        child: Text(this._content),
      ),
      backgroundColor: this._color,
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new FlatButton(
          child: new Text(this._no, style: new TextStyle(fontSize: 16)),
          textColor: Colors.grey,
          onPressed: () {
            Navigator.of(context).pop();
           },
        ),
        new FlatButton(
          child: new Text(this._yes, style: new TextStyle(fontSize: 16)),
          textColor: Colors.blueAccent,
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}