import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/models/Task.dart';
import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  final Task task;
  final Function press;

  const AnnouncementCard({
    Key key,
    this.task,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Hero(
                tag: "${"id"}",
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text("Title", overflow: TextOverflow.ellipsis),
                    ),
                    Spacer(),
                    Row(
                      children:<Widget>[
                        Expanded(
                          child: Container(),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            width: 250,
                            child: Text('sender: ' + "sender", overflow: TextOverflow.ellipsis,style: new TextStyle(fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
Expanded(
                      child: Container(
                        alignment: Alignment.bottomRight,
                        width: 250,
                        child: Text('sender: ' + "sender", overflow: TextOverflow.ellipsis,style: new TextStyle(fontSize: 12)),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
