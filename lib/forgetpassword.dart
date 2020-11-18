import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'Pattern/customBtn.dart';
import 'Pattern/customInput.dart';
import 'Pattern/design.dart';
class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}
FirebaseAuth auth = FirebaseAuth.instance;


class _ForgetPasswordState extends State<ForgetPassword> {
  String _email;
  bool _submitLoad = false;

  Future<String> resetPassword() async {
    try{
      await auth.sendPasswordResetEmail(email: _email);
      return null;
    } on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      }
      return "Invalid email!";
    }catch(e){
      return "Invalid email!";
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

  final GlobalKey<FormState> _formKey = GlobalKey();
  validateAndSave() async{
    final FormState form = _formKey.currentState;
    setState(() {
      _submitLoad = true;
    });
    String _validateAccount = await resetPassword();
    if (form.validate()) {

      print('Form is valid');
      Toast.show("The reset link is sent to your email!", context, duration: Toast.LENGTH_LONG);
      Navigator.pop(context);
    } else {
      Toast.show("Invalid Email", context);
      print('Form is invalid');
      setState(() {
        _submitLoad = false;
      });
    }

   /*  */
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24.0,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 24.0,
                ),
                child: Text(
                  "Forget Password",
                  textAlign: TextAlign.center,
                  style: Design.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    validator:  validateEmail,
                    onChanged: (value){
                        _email = value;
                    },
                    hintText: "Enter your email...",
                  ),
                  CustomBtn(
                    text: "Submit",
                    onPressed: () async{
                      validateAndSave();
                    },
                    isLoad: _submitLoad,
                    outlineBtn: false,
                  ),

                ],

              ),
            ],
          ),
        ),
      ),
    );
  }
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}

