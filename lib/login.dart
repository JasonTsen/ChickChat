import 'package:chickchat/Pattern/customBtn.dart';
import 'package:chickchat/Pattern/customInput.dart';
import 'package:chickchat/register.dart';
import 'package:chickchat/forgotpassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'Pattern/design.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _loginLoad = false;
  String _email;
  String _password;
  FocusNode _passwordFocus;

  Future<String> _login() async{
    try{
      await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(email: _email, password: _password);

      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return "Field cannot leave empty";
    }catch(e){
      return "Field cannot leave empty";
    }
  }
  Future<void> _alertDialog(String error) async{
    return showDialog(
        context:  context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
              title: Text("Error"),
              content: Container(
                child: Text(error),
              ),
              actions:[
                FlatButton(
                  child: Text("Close"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              ]
          );
        }
    );
  }
   void _submitLog() async{
    setState(() {
      _loginLoad = true;
    });
    String _validateAccount = await _login();
    if(_validateAccount != null){
      _alertDialog(_validateAccount);
      setState(() {
        _loginLoad = false;
      });
    }else{
      Toast.show("You have login as " + auth.currentUser.displayName + ".", context, duration: Toast.LENGTH_LONG);
      FirebaseFirestore.instance.collection('Users')
          .doc(auth.currentUser.uid)
          .update({'pass': _password});
    }
  }

  @override
  void initState(){
    super.initState();
    _passwordFocus = FocusNode();
  }
  @override
  void dispose(){
    _passwordFocus.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Container(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/chick.png"),
                Column(

                  children: [
                    Container(
                      child: Text(
                        "ChickChat",
                        textAlign: TextAlign.center,
                        style: Design.boldHeading,
                      ),
                    ),
                    CustomInput(
                      onChanged: (value){
                        _email = value;
                      },
                          hintText: "Enter Email...",
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: "Password...",
                      onChanged: (value) {
                        _password = value;
                      },
                      focusNode: _passwordFocus,
                      isPassField: true,
                      onSubmitted: (value) {
                        _submitLog();
                      },
                    ),
                    CustomBtn(
                      text: "Login",
                      onPressed: () async{
                        _submitLog();
                      },
                      outlineBtn: false,
                      isLoad: _loginLoad,
                    ),
                  ],
                ),
                CustomBtn(
                  text: "Forgot Password",
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword()
                      ),
                    );
                  },
                  outlineBtn: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: CustomBtn(
                    text: "Create New Account",
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage()
                        ),
                      );
                    },
                    outlineBtn: true,
                  ),
                ),
              ],
            ),
          ),
        ),

        ),
      );
  }
}