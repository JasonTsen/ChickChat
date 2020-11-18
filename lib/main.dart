import 'dart:io';
import 'package:chickchat/login.dart';
import 'package:chickchat/managerHome.dart';
import 'package:chickchat/staffHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Controller/notification.dart';
const bool kReleaseMode = bool.fromEnvironment('dart.vm.product', defaultValue: false);
Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'ChickChat',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: LandingPage(),
    );
  }
}
class LandingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LandingPageState();

}
class LandingPageState extends State<LandingPage>{
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  void initState() {
    NotificationController.instance.takeFCMTokenWhenAppLaunch();
    NotificationController.instance.initLocalNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Scaffold(
              body: Center(
                  child: Text("Error: ${snapshot.error}")
              )
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return StreamBuilder<User>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              User _user = snapshot.data;

              if (snapshot.connectionState == ConnectionState.active){
                print(snapshot);
                if (_user!= null) {
                  return StreamBuilder<QuerySnapshot>(
                      stream:
                      FirebaseFirestore.instance.collection("Users")
                      .where('uid', isEqualTo: _user.uid).snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {

                        if(snapshot.data == null||snapshot.data.docs.isEmpty || !snapshot.hasData){
                          return LoginPage();
                        }
                        else if (snapshot.hasData && snapshot.data != null) {
                          //print(userDoc.data());
                          // ignore: unrelated_type_equality_checks
                          final docs = snapshot.data.docs;
                          final user = docs[0].data();

                            if (user['role'] == 'Manager') {
                              return ManagerHomePage(currentUserId: _user.uid);

                            } else {
                              return StaffHomePage(currentUserId: _user.uid);
                            }
                        }
                        else {
                          return Material(child: Center(
                            child: CircularProgressIndicator(),),
                          );
                        }
                      }
                  );
                } else {
                  return LoginPage();
                  }

            } return Scaffold(
                body: Center(
                  child: Text("Connection to the app..."),
                ),
              );
            },

          );
        }
        return Scaffold(
          body: Center(
            child: Text("Connection to the app..."),
          ),
        );

      },
    );
  }
}

