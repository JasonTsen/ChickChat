import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'Pattern/customBtn.dart';
import 'Pattern/customInput.dart';
import 'Pattern/design.dart';
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}
FirebaseAuth auth = FirebaseAuth.instance;


class _ForgotPasswordState extends State<ForgotPassword> {
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
  _submitForgot() async{
    setState(() {
      _submitLoad = true;
    });
    String _validateAccount = await resetPassword();
    if(_validateAccount != null){
      _alertDialog(_validateAccount);
      setState(() {
        _submitLoad = false;
      });
    }else{
      Toast.show("The reset link is sent to your email!", context, duration: Toast.LENGTH_LONG);
      Navigator.pop(context);
    }
  }
  final GlobalKey<FormState> _formKey = GlobalKey();
  void validateAndSave() async{
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      print('Form is valid');
      _submitForgot();
    } else {
      print('Form is invalid');
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
                  "Forgot Password",
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
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}

