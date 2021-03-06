import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {

  Color _color = Colors.white;

  String _title;
  String _content;
  String _yes;
  Function _yesOnPressed;

  BaseAlertDialog({String title, String content, Function yesOnPressed, String yes = "Yes"}){
    this._title = title;
    this._content = content;
    this._yesOnPressed = yesOnPressed;
    this._yes = yes;
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
          child: new Text(this._yes, style: new TextStyle(fontSize: 16)),
          textColor: Colors.blueAccent,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}