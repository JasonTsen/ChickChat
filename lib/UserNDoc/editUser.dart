import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {

  final String currentUserId;
  EditProfile({Key key, @required this.currentUserId}):super(key:key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController passwordController = TextEditingController(text: "******");
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<DocumentSnapshot> getUserInfo()async{
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance.collection("Users").doc(firebaseUser.uid).get();
  }

  Column displayPhoneField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            'Phone No.',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: phoneNoController,
          decoration: InputDecoration(
            hintText: "Update Phone Number",
          ),
        )
      ],
    );
  }

  Column displayEmailField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            'Email',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Update Email",
          ),
        )
      ],
    );
  }

  Column displayPasswordField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            'Password',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Update Password",
          ),
        )
      ],
    );
  }

  updateData()async{
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection("Users").doc(firebaseUser.uid).update(
    {
      'phone':phoneNoController.text,
      'email': emailController.text,
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                CupertinoIcons.checkmark_alt,
                size: 30.0,
                color: Colors.blueAccent,
              ),
              onPressed: ()=> Navigator.pop(context),
          )
        ],
      ),
      body: FutureBuilder(
        future: getUserInfo(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            phoneNoController.text = snapshot.data['phone'];
            emailController.text = snapshot.data['email'];
            return Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: Column(
                  children: <Widget>[
                    displayPasswordField(),
                    displayEmailField(),
                    displayPhoneField(),
                    RaisedButton(
                        onPressed: updateData,
                      child: Text(
                        'Update',
                      ),
                    )
                  ],
                ),
              ),

            );
          }else if(snapshot.connectionState == ConnectionState.none){
            return Text('No data');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
