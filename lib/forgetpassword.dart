import 'package:flutter/material.dart';
import 'Pattern/customBtn.dart';
import 'Pattern/customInput.dart';
class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24.0,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    onChanged: (value){
                      _email = value;
                    },
                    hintText: "Enter your email...",
                    textInputAction: TextInputAction.next,
                  ),

                  CustomBtn(
                    text: "Submit",
                    onPressed: (){

                    },

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
}
