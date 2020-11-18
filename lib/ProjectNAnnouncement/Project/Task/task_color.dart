import 'package:chickchat/models/Project.dart';
import 'package:flutter/material.dart';

class TaskColor extends StatelessWidget {
  const TaskColor({
    Key key,
    @required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 3.0, right: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xffff80ac),
                        border: Border.all(
                            width: 10.0, color: const Color(0x00000000)),
                      ),
                    ),
                  Text(
                    'To do',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xff101010),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5.0, right: 7.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xff26cc2c),
                      border: Border.all(
                          width: 10.0, color: const Color(0x00000000)),
                    ),
                  ),
                  Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xff101010),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 3.0, right: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xff7ee1ff),
                      border: Border.all(
                          width: 10.0, color: const Color(0x00000000)),
                    ),
                  ),
                  Text(
                    'In progress',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xff101010),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 3.0, right: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color(0xffffd86f),
                      border: Border.all(
                          width: 10.0, color: const Color(0x00000000)),
                    ),
                  ),
                  Text(
                    'Rejected',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xff101010),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
