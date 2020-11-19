import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class UserProfile extends StatefulWidget {

  final String currentUserId;
  UserProfile({Key key, @required this.currentUserId}):super(key:key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final String currentUserId;
  _UserProfileState({Key key, @required this.currentUserId});

  String name, email, password, phone;

  final CollectionReference profileList = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
              future: getUserInfo(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20,left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    'User Profile',
                                  style: TextStyle(
                                    fontSize: 26,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 600,
                              child: Stack(
                                  children: <Widget>[
                                    ListView(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Container(
                                                width: 400.0,
                                                height: 300.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius: BorderRadius.circular(6.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        'Profile',
                                                        style: TextStyle(
                                                            fontSize: 25.0
                                                        ),
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      Text(
                                                        'Name'
                                                      ),
                                                      SizedBox(height: 5.0),
                                                      Text(
                                                        snapshot.data["name"],
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                      Divider(
                                                        color: Colors.grey[800],
                                                        endIndent: 120,
                                                      ),
                                                      SizedBox(height: 15.0),
                                                      Text(
                                                        'Password',
                                                      ),
                                                      SizedBox(height: 5.0),
                                                      Text(
                                                        '******',
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                      Divider(
                                                        color: Colors.grey[800],
                                                        endIndent: 120,
                                                      ),
                                                      SizedBox(height: 15.0),
                                                      Text(
                                                        'Role',
                                                      ),
                                                      SizedBox(height: 5.0),
                                                      Text(
                                                        snapshot.data['role'],
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                      Divider(
                                                        color: Colors.grey[800],
                                                        endIndent: 120,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Container(
                                                width: 400.0,
                                                height: 220.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius: BorderRadius.circular(6.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        'Contact',
                                                        style: TextStyle(
                                                            fontSize: 25.0
                                                        ),
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      Text(
                                                        'Email',
                                                      ),
                                                      SizedBox(height: 5.0),
                                                      Text(
                                                        snapshot.data['email'],
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                      Divider(
                                                        color: Colors.grey[800],
                                                        endIndent: 120,
                                                      ),
                                                      SizedBox(height: 15.0),
                                                      Text(
                                                        'Phone No.',
                                                      ),
                                                      SizedBox(height: 5.0),
                                                      Text(
                                                        snapshot.data['phone'],
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                      Divider(
                                                        color: Colors.grey[800],
                                                        endIndent: 120,
                                                      ),
                                                      SizedBox(height: 15.0),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: RaisedButton(
                                        child: Text("Log out"),
                                        onPressed: () async{
                                          Toast.show("You have logged out successfully!", context, duration: Toast.LENGTH_LONG);
                                          Navigator.pop(context);
                                          await FirebaseAuth.instance.signOut();
                                        },
                                      ),
                                    ),
                                  ]
                              ),

                            ),
                          ],
                        );

                      });
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Text("No data");
                }
                return CircularProgressIndicator();
              },
            ),
    );
  }



  Future<DocumentSnapshot> getUserInfo()async{
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance.collection("Users").doc(firebaseUser.uid).get();
  }

}
