import 'package:flutter/material.dart';

enum TaskStatus { ToDo, Done, InProgress, Rejected}

class MyTaskStatus extends StatefulWidget {
  MyTaskStatus({Key key}) : super(key: key);

  @override
  _MyTaskStatusState createState() => _MyTaskStatusState();
}

class _MyTaskStatusState extends State<MyTaskStatus> {
  TaskStatus _status = TaskStatus.ToDo;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
            ListTile(
              title: const Text('To Do'),
              leading: Radio(
                value: TaskStatus.ToDo,
                groupValue: _status,
                onChanged: (TaskStatus value) {
                  setState(() {
                    _status = value;
                  });
                },
              ),
        ),
        ListTile(
          title: const Text('Done'),
          leading: Radio(
            value: TaskStatus.Done,
            groupValue: _status,
            onChanged: (TaskStatus value) {
              setState(() {
                _status = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('In Progress'),
          leading: Radio(
            value: TaskStatus.InProgress,
            groupValue: _status,
            onChanged: (TaskStatus value) {
              setState(() {
                _status = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Rejected'),
          leading: Radio(
            value: TaskStatus.Rejected,
            groupValue: _status,
            onChanged: (TaskStatus value) {
              setState(() {
                _status = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
