import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/app_bar.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/details_screen.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/item_card.dart';
import 'package:chickchat/models/Project.dart';
import 'package:flutter/material.dart';

class ProjectList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin, vertical: 10),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                  itemCount: projects.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                    project: projects[index],
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            project: projects[index],
                          ),
                        )),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
