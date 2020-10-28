import 'package:chickchat/StaffChatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  Future<void> _login() async{
    try{
      UserCredential userCredential = await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      print("User: $userCredential");
    } on FirebaseAuthException catch(e) {
      print("Error: $e");
    }catch(e){
      print("Error: $e");
    }
  }
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value){
                _email = value;
              },
              decoration: InputDecoration(
                hintText: "Enter Email..."
              ),
            ),
            TextField(
              onChanged: (value){
                _password = value;
              },
              decoration: InputDecoration(
                  hintText: "Enter Password..."
              ),
            ),

                MaterialButton(
                  onPressed: _login,
                  child: Text("Login"),
                ),
                MaterialButton(
                  onPressed: (){},
                  child: Text("Forget Password"),
                ),



          ],
        ),
      ),
    );
  }
}