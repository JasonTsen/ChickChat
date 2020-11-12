
import 'file:///C:/Users/tsenj/chickchat/lib/Pattern/customBtn.dart';
import 'file:///C:/Users/tsenj/chickchat/lib/Pattern/customInput.dart';
import 'package:chickchat/register.dart';
import 'package:chickchat/forgetpassword.dart';
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
      if(e.code == 'weak-password'){
        return 'The password provided is too weak';
      }else if(e.code == 'email-already-in-use'){
        return 'The account already exists for that email.';
      }
      return e.message;
    }catch(e){
      return e.toString();
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
    }
    Toast.show("You have login as " + auth.currentUser.displayName + ".", context, duration: Toast.LENGTH_LONG);
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

      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 24.0,
                  ),
                ),
                Column(
                  children: [

                    Container(
                      padding: EdgeInsets.only(
                      top: 24.0,
                ),
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
                      onChanged: (value){
                        _password = value;
                      },
                        onSubmitted: (value){
                          _submitLog();
                        },
                        focusNode: _passwordFocus,
                        isPassField: true,
                          hintText: "Enter Password..."
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
                  text: "Forget Password",
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPassword()
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