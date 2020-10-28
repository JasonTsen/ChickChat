import 'package:chickchat/design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  Future<void> _userSetup(String displayName, String password) async{
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    users.add({ 'uid': uid, 'displayName': displayName, 'password': password});
    return;
  }
  Future<void> _createUser() async{
    try{
      UserCredential userCredential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      print("User: $userCredential");
      User updateUser = FirebaseAuth.instance.currentUser;
      updateUser.updateProfile(displayName: _name);
      _userSetup(_name, _password);
    } on FirebaseAuthException catch(e) {
      print("Error: $e");
    }catch(e){
      print("Error: $e");
    }


  }

  String _name, _email, _password, _userRole, _userImg, _phone;
  String _department;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value){
                _name = value;
              },
              decoration: InputDecoration(
                  hintText: "Name"
              ),
            ),
            TextField(
              onChanged: (value){
                _email = value;
              },
              decoration: InputDecoration(
                  hintText: "Email"
              ),
            ),

            TextField(
              onChanged: (value){
                _password = value;
              },
              decoration: InputDecoration(
                  hintText: "Password"
              ),
            ),


            RaisedButton(
              onPressed: _createUser,
              child: Text("Register"),
            ),

          ],
        ),
      ),
    );
  }
}
