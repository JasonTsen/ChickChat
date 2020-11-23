import 'package:cached_network_image/cached_network_image.dart';
import 'package:chickchat/UserNDoc/change_password.dart';
import 'package:chickchat/UserNDoc/editUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder(
        future: getUserInfo(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            /*return ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {*/
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Container(
                        height: 100,
                        width: 100,
                        child: Stack(
                          children: <Widget>[
                            Material(
                              child: snapshot.data['userImg'] != null
                                  ? CachedNetworkImage(
                                placeholder: (context, url) =>
                                    Container(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.0,
                                        valueColor:
                                        AlwaysStoppedAnimation<Color>(Colors.amber),
                                      ),
                                      width: 50.0,
                                      height: 50.0,
                                      padding: EdgeInsets.all(15.0),
                                    ),
                                imageUrl: snapshot.data['userImg'],
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              )
                                  : Icon(
                                Icons.account_circle,
                                size: 50.0,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(100.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    CupertinoIcons.pen,
                                    size: 15,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        snapshot.data['name'],
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50)
                            .copyWith(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            Icon(
                              CupertinoIcons.mail,
                              size: 30,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              snapshot.data['email'],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50)
                            .copyWith(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            Icon(
                              CupertinoIcons.phone,
                              size: 30,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Phone No',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              snapshot.data['phone'],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50)
                            .copyWith(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            Image(
                              image: AssetImage('assets/images/profile.png'),
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Role',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              snapshot.data['role'],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 310,
                          margin: EdgeInsets.symmetric(horizontal: 50)
                              .copyWith(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Icon(
                                Icons.lock_outlined,
                                size: 30,
                              ),
                              SizedBox(width: 70),
                              Text('Change Password'),
                            ],
                          ),
                        ),
                        onTap: (){
                          showDialog(context: context, builder: (context){
                            return Container(
                              child: AlertDialog(
                                title: Text('Change Password'),
                                content: Text('Proceed to change password?'),
                                actions: <Widget>[
                                  MaterialButton(
                                    child: Text('CANCEL'),
                                    onPressed: (){
                                      Navigator.of(context).pop('CANCEL');
                                    },
                                  ),
                                  MaterialButton(
                                    child: Text('OK'),
                                    onPressed: (){
                                      Navigator.of(context).pop('OK');
                                    },
                                  )
                                ],
                              ),
                            );
                          }).then((result) async{
                            if(result == 'OK'){
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ChangePassword(currentUserId: currentUserId)));
                            }
                          });
                        },
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 310,
                          margin: EdgeInsets.symmetric(horizontal: 50)
                              .copyWith(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Icon(
                                Icons.settings_rounded,
                                size: 30,
                              ),
                              SizedBox(width: 90),
                              Text('Edit Profile'),
                            ],
                          ),
                        ),
                        onTap: (){
                          showDialog(context: context, builder: (context){
                            return Container(
                              child: AlertDialog(
                                title: Text('Edit Profile'),
                                content: Text('Proceed to edit profile?'),
                                actions: <Widget>[
                                  MaterialButton(
                                    child: Text('CANCEL'),
                                    onPressed: (){
                                      Navigator.of(context).pop('CANCEL');
                                    },
                                  ),
                                  MaterialButton(
                                    child: Text('OK'),
                                    onPressed: (){
                                      Navigator.of(context).pop('OK');
                                    },
                                  )
                                ],
                              ),
                            );
                          }).then((result) async{
                            if(result == 'OK'){
                              Navigator.pop(context);
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => EditProfile(currentUserId: currentUserId)));
                            }
                          });
                        },
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 310,
                          margin: EdgeInsets.symmetric(horizontal: 50)
                              .copyWith(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Icon(
                                Icons.exit_to_app_rounded,
                                size: 30,
                              ),
                              SizedBox(width: 100),
                              Text('Logout'),
                            ],
                          ),
                        ),
                        onTap: (){
                              showDialog(context: context, builder: (context){
                                return Container(
                                  child: AlertDialog(
                                    title: Text('Logout'),
                                    content: Text('Are you sure to logout?'),
                                    actions: <Widget>[
                                      MaterialButton(
                                        child: Text('CANCEL'),
                                        onPressed: (){
                                          Navigator.of(context).pop('CANCEL');
                                        },
                                      ),
                                      MaterialButton(
                                        child: Text('LOGOUT'),
                                        onPressed: (){
                                          Navigator.of(context).pop('LOGOUT');
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }).then((result) async{
                                if(result == 'LOGOUT'){
                                  Toast.show('You have logged out successfully!',context,duration: Toast.LENGTH_LONG);
                                  Navigator.pop(context);
                                  await FirebaseAuth.instance.signOut();
                                }
                              });
                        },
                      ),

                    ],
                  );

//                });
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




