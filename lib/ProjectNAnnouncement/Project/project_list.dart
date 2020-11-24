import 'package:chickchat/Controller/constants.dart';
import 'package:chickchat/Pattern/design.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/app_bar.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/delete_project_confirmation.dart';
import 'package:chickchat/ProjectNAnnouncement/Project/project_details_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ProjectList extends StatefulWidget{
  ProjectList({Key key}) : super (key: key);

  @override
  State createState() => ProjectListState();
}

class ProjectListState extends State<ProjectList> {
  ProjectListState({Key key});

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

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
              child: StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection('Projects')
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
                      padding: EdgeInsets.all(10.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: kDefaultPaddin,
                        crossAxisSpacing: kDefaultPaddin,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) =>
                          itemCard(
                              context, snapshot.data.documents[index]
                          ),
                      itemCount: snapshot.data.documents.length,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future <void> _deleteProject (String id) async {
  FirebaseFirestore.instance.collection('Projects').doc(id).delete();
}

Widget itemCard(BuildContext context, DocumentSnapshot document) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
              DetailsBuilder(
                id: document.id,
                collaborators: document.data()['collaborators'],
                title: document.data()['title'],
                percentage: document.data()['percentage'],
                color: document.data()['color'],
                description: document.data()['description'],
              ),
          ),
      );
    },
    onLongPress: (){
      var baseDialog = DeleteProjectConfirmation(
        title: "Delete Project:",
        content: "Are you sure to delete this project?",
        yesOnPressed: () {
          _deleteProject(document.id);
          Toast.show("Project Deleted!", context,  duration: Toast.LENGTH_LONG);
          Navigator.pop(context);
        },
        noOnPressed: (){
          Navigator.of(context).pop();
        },
        yes: "Delete",
        no:"Cancel",
      );
      showDialog(context: context, builder: (BuildContext context) => baseDialog);
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(kDefaultPaddin),
            decoration: BoxDecoration(
              color: Color(int.parse(document.data()['color'])),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Hero(
              tag: "${document.id}",
              child: Image.asset(document.data()['image']),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
          child: Text(
            // products is out demo list
            document.data()['title'],
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}
