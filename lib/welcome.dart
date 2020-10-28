import 'package:chickchat/login.dart';
import 'package:chickchat/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

              Text(
                'ChickChat',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 45,
                  color: const Color(0xff807e7e),
                ),
                textAlign: TextAlign.left,
              ),

            RaisedButton(
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => LoginPage()));
              },
              child: Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 34,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => RegisterPage()));
              },
              child: Text("Register", style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 31,
                color: const Color(0xffffffff),
              ),
              ),

            )
          ],

        ),

      ),
    );
  }
}
