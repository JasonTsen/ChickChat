import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/task_card.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/Task/task_details.dart';
import 'package:chickchat/models/Task.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.id
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Expanded(
     child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: GridView.builder(
            itemCount: tasks.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: kDefaultPaddin,
              crossAxisSpacing: kDefaultPaddin,
              childAspectRatio: 4.0,
            ),
            itemBuilder: (context, index) => TaskCard(
              task: tasks[index], //to look in Task.dart (using item index)
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetails( //will route to task_details
                      task: tasks[index],
                    ),
                  )),
            )),
      ),
    );
  }
}
