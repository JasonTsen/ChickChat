import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/Pattern/design.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/task_card.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/task_details.dart';
import 'package:chickchat/models/Task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.id,
    this.task,
  }) : super(key: key);

  final String id;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Expanded(
     child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Projects')
              .doc(id)
              .collection("Tasks")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Design.themeColor),
                ),
              );
            } else {
              return GridView.builder(
                    itemCount:  snapshot.data.documents.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: kDefaultPaddin,
                      crossAxisSpacing: kDefaultPaddin,
                      childAspectRatio: 4.0,
                    ),
                    itemBuilder: (context, index) => taskCard(
                      context,
                      snapshot.data.documents[index],
                    )
                );
            }
          },
        ),
      ),
    );
  }

  Widget taskCard(BuildContext context, DocumentSnapshot document) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TaskDetails(
                  id: document.id,
                ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(int.parse(document.data()['color'])),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Hero(
                tag: "${document.id}",
                child: Text(document.data()['taskTitle'], style: new TextStyle(color:Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
