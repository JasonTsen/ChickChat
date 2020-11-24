import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chickchat/UserNDoc/change_password.dart';
import 'package:chickchat/UserNDoc/editUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
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

  TextEditingController phoneNoController = TextEditingController();
  TextEditingController custom = TextEditingController();

  String name, email, password, phone;
  String rename, uploadImg, newPhone;

  final CollectionReference profileList = FirebaseFirestore.instance.collection('Users');
  File imageFile;
  final _picker = ImagePicker();

  Future<void> uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('userImages/${imageFile.path}');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    print("file uploaded");
    uploadImg = await taskSnapshot.ref.getDownloadURL();
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection("Users").doc(firebaseUser.uid).update(
        {
          'userImg':uploadImg.toString(),
        });
  }

  Future  _openGallery() async{
    final picture = await _picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      if(picture != null){
        imageFile = File(picture.path);
      }else{
        print("No image selected.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder(
        future: getUserInfo(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
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
                              onPressed: ()async{
                                _openGallery();
                                    showDialog(context: context, builder: (context){
                                      return Container(
                                        child: AlertDialog(
                                          title: Text('Confirm Update?'),
                                          content: Text('Update your new profile picture'),
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
                                    }).then((result)async{
                                      if(result == 'OK'){
                                        uploadFile();
                                        Toast.show('Profile picture updated',context,duration: Toast.LENGTH_LONG);
                                        Navigator.of(context).pop();
                                      }
                                    });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 30)
                        .copyWith(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.account_circle_outlined,
                          size: 30,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          snapshot.data['name'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 50),
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.ellipsis,
                            color: Colors.grey,
                          ),
                          onPressed: (){
                            showModalBottomSheet(context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext bc){
                                  return Container(
                                    height: MediaQuery.of(context).size.height * .60,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                        )
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10.0),
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height * .30,
                                                    width: 360,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(6.0),
                                                        )
                                                    ),
                                                    child: Column(
                                                      children: <Widget>[
                                                        SizedBox(height: 10),
                                                        Text('Modify User Name',
                                                          style: TextStyle(
                                                            fontSize: 20,
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
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                            child: TextField(
                                                              controller: custom,
                                                              decoration: InputDecoration(
                                                                  hintText: 'User Name'
                                                              ),
                                                              onChanged: (text){
                                                                rename = custom.text;
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        RaisedButton(
                                                          onPressed:()async{
                                                            showDialog(context: context, builder: (context){
                                                              return Container(
                                                                child: AlertDialog(
                                                                  title: Text('Confirm Update?'),
                                                                  content: Text('New user name will be updated.'),
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
                                                            }).then((result)async{
                                                              if(result == 'OK'){
                                                                var firebaseUser = await FirebaseAuth.instance.currentUser;
                                                                await FirebaseFirestore.instance.collection("Users").doc(firebaseUser.uid).update(
                                                                    {
                                                                      'name':rename,
                                                                    });
                                                                Navigator.of(context).pop();
                                                                Navigator.of(context).pop();
                                                                Toast.show('User name updated',context,duration: Toast.LENGTH_LONG);
                                                              }
                                                            });
                                                          },
                                                          child: Text('Confirm'),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 30)
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
                    margin: EdgeInsets.symmetric(horizontal: 30)
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
                        SizedBox(width: 30),
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.ellipsis,
                            color: Colors.grey,
                          ),
                          onPressed: (){
                            showModalBottomSheet(context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext bc){
                                  return Container(
                                    height: MediaQuery.of(context).size.height * .60,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                        )
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10.0),
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height * .30,
                                                    width: 360,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(6.0),
                                                        )
                                                    ),
                                                    child: Column(
                                                      children: <Widget>[
                                                        SizedBox(height: 10),
                                                        Text('New Phone Number',
                                                          style: TextStyle(
                                                            fontSize: 20,
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
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                            child: TextField(
                                                              controller: phoneNoController,
                                                              decoration: InputDecoration(
                                                                hintText: 'New Phone Number'
                                                              ),
                                                              onChanged: (text){
                                                                newPhone = phoneNoController.text;
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        RaisedButton(
                                                            onPressed:()async{
                                                              showDialog(context: context, builder: (context){
                                                                return Container(
                                                                  child: AlertDialog(
                                                                    title: Text('Confirm Update?'),
                                                                    content: Text('New phone number will be updated.'),
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
                                                              }).then((result)async{
                                                                if(result == 'OK'){
                                                                  var firebaseUser = await FirebaseAuth.instance.currentUser;
                                                                    await FirebaseFirestore.instance.collection("Users").doc(firebaseUser.uid).update(
                                                                    {
                                                                      'phone':newPhone,
                                                                    });
                                                                    Navigator.of(context).pop();
                                                                }
                                                              });
                                                            },
                                                          child: Text('Confirm'),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 30)
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
                      margin: EdgeInsets.symmetric(horizontal: 30)
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
                      margin: EdgeInsets.symmetric(horizontal: 30)
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
                          SizedBox(width: 60),

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
              ),
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




